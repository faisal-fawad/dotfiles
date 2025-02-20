#!/usr/bin/env bash

# Current Theme
dir="~/.config/rofi/"
theme='catppuccin-mocha-powermenu'

# CMDs
uptime="`uptime -p | sed -e 's/up //g'`"

# Options
hibernate='󰤄'
shutdown='󰐥'
reboot=''
lock=''
logout=''

# Rofi CMD
rofi_cmd() {
	rofi -dmenu \
		-mesg "Uptime: $uptime" \
		-theme ${dir}/${theme}.rasi
}

# Confirmation CMD
confirm_cmd() {
	rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 350px;}' \
		-theme-str 'mainbox {children: [ "message", "listview" ];}' \
		-theme-str 'listview {columns: 2; lines: 1;}' \
		-theme-str 'element-text {horizontal-align: 0.5;}' \
		-theme-str 'textbox {horizontal-align: 0.5;}' \
		-dmenu \
		-theme ${dir}/${theme}.rasi
}

# Pass variables to rofi dmenu
run_rofi() {
    echo -e "$reboot\n$shutdown\n$lock\n$logout\n$hibernate" | rofi_cmd
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $shutdown)
		systemctl poweroff
        ;;
    $reboot)
		systemctl reboot
        ;;
    $hibernate)
		echo "hibernation!"
		systemctl hibernate
        ;;
    $lock)
		# Specific to i3/betterlockscreen
		if [[ -x '/usr/bin/betterlockscreen' ]]; then
			betterlockscreen -l
		elif [[ -x '/usr/bin/i3lock' ]]; then
			i3lock
		fi
        ;;
    $logout)
		# Specific to i3
		i3-msg exit
        ;;
esac
