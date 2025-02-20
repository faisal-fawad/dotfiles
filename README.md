# dotfiles

Documentation for setting up my core configuration!

### Installation

Requirements:
- [Neovim](https://neovim.io/)
- [Wezterm](https://wezfurlong.org/wezterm/installation.html)
- Basic utils: `git`, `make`, `unzip`, `gcc`
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation)
- Clipboard tool (`xclip`/`xsel`/`win32yank` or other depending on the platform)
- A [Nerd Font](https://www.nerdfonts.com/). Once installed:
  - Set `config.font = wezterm.font "<font>"` in root Wezterm configuration
  - Set `vim.g.have_nerd_font = true` in root Neovim configuration

> **NOTE**
> See [Install Recipes](#Install-Recipes) for additional Windows and Linux specific notes
> and quick install snippets

### Install Recipes

Below you can find OS specific install instructions...

#### Windows Installation

<details><summary>Windows Install Steps</summary>

Install Neovim, Wezterm, and it's dependencies:

```sh
choco install -y neovim git ripgrep wget fd unzip gzip mingw make wezterm
git clone https://github.com/faisal-fawad/dotfiles
xcopy dotfiles\nvim "%localappdata%/nvim" /s /e /i /h /y
xcopy dotfiles\wezterm "%userprofile%/.config/wezterm" /s /e /i /h /y
```

</details>

#### Linux Installation

<details><summary>Arch Linux Install Steps</summary>

Install everything:

```sh
# Basic utilities
sudo pacman -S gcc make git ripgrep fd unzip stow xclip

# Font: JetBrains Mono
sudo pacman -S ttf-jetbrains-mono-nerd

# Wezterm, AUR is more up-to-date then official repository
# NOTE: This will take a while
yay -S wezterm-git

# Neovim
sudo pacman -S neovim

# Polybar + Support for Spotify integration (zscroll, journalctl)
# See here for more: https://github.com/PrayagS/polybar-spotify
sudo pacman -S polybar
sudo pacman -S python-distutils-extra
yay -S zscroll-git

# i3
sudo pacman -S i3-wm

# Rofi
sudo pacman -S rofi

# Picom
sudo pacman -S picom

# Spotify + Spicetify:
# See here for more: https://github.com/catppuccin/spicetify
sudo pacman -S spotify-launcher
yay -S spicetify-cli

# Discord via Vencord:
yay -S vesktop

# For Firefox, see here: https://github.com/catppuccin/firefox

# Clone repository and stow each directory for configuration
git clone https://github.com/faisal-fawad/dotfiles
stow <dir>
```

NOTE: The set of commands was ran after the EndeavorOS (i3wm flavour) installer and may be missing some prerequisites!
</details>
