# dotfiles

My development workflow, managed by [GNU Stow](https://www.gnu.org/software/stow/). This is primarily Linux-based but some tools can also be installed on Windows!

### Overview

| Component | Linux | Windows |
| --- | --- | --- |
| **Operating System** | [EndeavorOS](https://endeavouros.com/) | [Windows 11](https://www.microsoft.com/en-ca/windows/) |
| **Window Manager** | [i3wm](https://i3wm.org/) | [GlazeWM](https://github.com/glzr-io/glazewm) |
| **Theme** | [Catppuccin](https://catppuccin.com/) | Identical |
| **Editor** | [Neovim](https://neovim.io/) | Identical |
| **Terminal** | [WezTerm](https://wezterm.org/index.html) | Identical |
| **Shell** | [zsh](https://www.zsh.org/) | [Git Bash](https://gitforwindows.org/) |

### Installation

See [Install Recipes](#Install-Recipes) for Windows and Linux specific notes and quick install snippets

### Install Recipes

#### Windows Installation

<details><summary>Windows Install Steps</summary>

Install Neovim, WezTerm, and it's dependencies:

```sh
choco install -y neovim git ripgrep wget fd unzip gzip mingw make wezterm
git clone https://github.com/faisal-fawad/dotfiles
xcopy dotfiles\nvim\.config\nvim "%localappdata%/nvim" /s /e /i /h /y
xcopy dotfiles\wezterm\.config\wezterm "%userprofile%/.config/wezterm" /s /e /i /h /y
```

NOTE: By installing `git`, Git Bash should also be installed!
</details>

#### Linux Installation

<details><summary>Arch Linux Install Steps</summary>

Install everything and load configuration:

```sh
# Basic utilities
sudo pacman -S gcc make git ripgrep fd unzip stow xclip

# Clone repository and stow each directory for symlinking
git clone https://github.com/faisal-fawad/dotfiles
stow dir # stow i3, stow picom, stow rofi, ... etc.

# Font: JetBrains Mono
sudo pacman -S ttf-jetbrains-mono-nerd

# Icons: Papirus
sudo pacman -S papirus-icon-theme

# Terminal Emulator: Wezterm
# NOTE: The official repository is often behind and hence we are using AUR
yay -S wezterm-git

# IDE: Neovim
sudo pacman -S neovim

# Status Bar: Polybar + Support for Spotify integration (zscroll, journalctl)
# See here for more: https://github.com/PrayagS/polybar-spotify
sudo pacman -S polybar
sudo pacman -S python-distutils-extra
yay -S zscroll-git

# Window Manager: i3
sudo pacman -S i3-wm

# Compositor: Picom
sudo pacman -S picom

# "Spotlight Search": Rofi
sudo pacman -S rofi

# Notifications: dunst
sudo pacman -S dunst

# Lock: betterlockscreen
yay -S betterlockscreen
betterlockscreen -u ~/.config/images/wallpaper.jpg

# Image Viewer: feh
sudo pacman -S feh

# Screenshots: Flameshot
sudo pacman -S flameshot 

# File System Navigator: Thunar 
sudo pacman -S thunar

# Themed applications below!

# Spotify + Spicetify:
# See here for more: https://github.com/catppuccin/spicetify
sudo pacman -S spotify-launcher
yay -S spicetify-cli

# Discord via Vencord:
yay -S vesktop

# For Firefox, see here: https://github.com/catppuccin/firefox
```

NOTE: The set of commands was ran after the EndeavorOS installer and may be missing some prerequisites!
</details>
