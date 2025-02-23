#!/usr/bin/env bash

notify-send "Getting list of available Wi-Fi networks..."

# Get saved connections
saved_connections=$(nmcli -g NAME connection)

fields="SSID,SIGNAL,FREQ"
base_wifi_list=$(nmcli -t --fields "$fields" device wifi list)
wifi_list=""
ssid_list=()

# Process wifi connections line by line
while read -r line; do 
  # Extract SSID, signal strength, and frequency from the line
  ssid=$(echo "$line" | awk -F':' '{print $1}')
  signal=$(echo "$line" | awk -F':' '{print $2}')
  freq=$(echo "$line" | awk -F':' '{print $3}')

  # Skip SSIDs that contain a dash
  if [[ -z "$ssid" ]]; then
    continue
  fi
  
  # Check if the SSID is in the saved connections list
  if [[ $(echo "$saved_connections" | grep -w "$ssid") ]]; then
    lock_symbol=""
  else
    lock_symbol=""
  fi

  # Map signal strength to respective icon
  if (( signal >= 75 )); then
    # Strong
    signal_strength="󰤨"
  elif (( signal >= 50 )); then
    # Medium
    signal_strength="󰤥"
  elif (( signal >= 25 )); then
    # Weak
    signal_strength="󰤢"
  else
    # Very weak
    signal_strength="󰤟"
  fi

  # Append to list
  wifi_list+="$lock_symbol $signal_strength  $ssid ($freq)"$'\n'
  ssid_list[${#ssid_list[@]}]="$ssid"

done <<< "$base_wifi_list"

# Remove \n at the end of the list
if (( "${#wifi_list}" - 3 >= 0 )); then
	wifi_list=${wifi_list::-3}
fi

connected=$(nmcli -fields WIFI g)
if [[ "$connected" =~ "enabled" ]]; then
	toggle="󰖪  Disable Wi-Fi"
elif [[ "$connected" =~ "disabled" ]]; then
	toggle="󰖩  Enable Wi-Fi"
fi

# Use rofi to select wifi network
chosen_network_index=$(echo -e "$toggle\n$wifi_list" | rofi -dmenu -format i -selected-row 1 -p "Wi-Fi SSID: " )
if [[ -z "$chosen_network_index" ]]; then
	# The user exited without selecting an option
	exit 1
fi

if (( $chosen_network_index == 0)); then
	state=$(nmcli radio wifi)
	if [[ "$state" = "enabled" ]]; then
		nmcli radio wifi off
	else
		nmcli radio wifi on
	fi
else
	chosen_id=${ssid_list[chosen_network_index - 1]}
	# Message to show when connection is activated successfully
	success_message="You are now connected to the Wi-Fi network \"$chosen_id\""

	if [[ $(echo "$saved_connections" | grep -w "$chosen_id") = "$chosen_id" ]]; then
		# If the connection is saved, simply try and connect
		new_connection=$(nmcli connection up id "$chosen_id")

		if [[ $(echo "$new_connection" | grep -w "successfully") ]]; then
			notify-send "Connected Established" "$success_message"
		else
			nmcli connection delete id "$chosen_id"
			notify-send "Connection Failed" "Incorrect password"
		fi
	else
		# Prompt for password 
		wifi_password=$(rofi -dmenu -p "Password: " )
		new_connection=$(nmcli device wifi connect "$chosen_id" password "$wifi_password")

		if [[ $(echo "$new_connection" | grep -w "successfully") ]]; then
			notify-send "Connected Established" "$success_message"
		else
			nmcli connection delete id "$chosen_id"
			notify-send "Connection Failed" "Incorrect password"
		fi
	fi
fi
