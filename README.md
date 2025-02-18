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

Install Neovim, Wezterm, and it's dependencies:

```sh
sudo pacman -S --noconfirm --needed gcc make git ripgrep fd unzip neovim stow
git clone https://github.com/faisal-fawad/dotfiles
stow <dir>
```

NOTE: Wezterm must be installed by following the documentation as the Arch repository is often behind the latest release!
</details>
