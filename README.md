<h1 align="center">
	BruhOS ❄️ NixOS Config
</h1>

<h6 align="center">
  <a href="#ℹ%EF%B8%8F-info">Information</a>
  ·
  <a href="#%EF%B8%8F-installation">Installation</a>
  ·
  <a href="#%EF%B8%8F-screenshots">Screenshots</a>
  ·
  <a href="#-documentation">Documentation</a>
</h6>

<h3 align="center">
	Color Palette
</h3>

<p align="center">
  <img src="https://raw.githubusercontent.com/BruhaBruh/BruhOS/main/assets/macchiato.png" width="400" />
</p>

### ℹ️ Info

- Package count: 📦 1947
- Uses the Catppuccin Macchiato theme
- Terminal emulator: 🦶 foot
- Window manager: 🌿 Hyprland
- Shell: 🐚 zsh
- Editor: 📝 vim/code
- Browser: 🦊 Zen Browser
- Other: rofi, Hyprpaper, Hyprpicker, swaync

### 🛠️ Installation

#### 1. Install NixOS

Format disk with disko and install NixOS

```bash
sh <(curl -L https://github.com/BruhBruh/BruhOS/raw/main/nixos.sh)

reboot
```

#### 2. Set passwd to user

Log in to the root, change the password using the command below and log out after that

```bash
passwd username
```

#### 3. Install BruhOS

Log in to the user and run the command below

```bash
sh <(curl -L https://github.com/BruhBruh/BruhOS/raw/main/install.sh)
```

### 🖼️ Screenshots

![Screenshot 1](https://raw.githubusercontent.com/BruhaBruh/BruhOS/main/assets/screenshot0.jpg)
![Screenshot 2](https://raw.githubusercontent.com/BruhaBruh/BruhOS/main/assets/screenshot1.jpg)

### 📚 Documentation

#### Key bindings

`SUPER` - is Win key by default

- `SUPER + Q` - Run terminal
- `SUPER + SPACE` - Run rofi
- `SUPER + E` - Run file browser
- `SUPER + R` - Run color picker
- `SUPER + S` - Make fullscreen screenshot
- `SUPER + SHIFT + S` - Make screenshot with selected area
- `SUPER + B` - Kill waybar
- `SUPER + R` - Reload waybar
- `SUPER + LEFT_CLICK` - Move window with cursor
- `SUPER + RIGHT_CLICK` - Resize window with cursor
- `SUPER + F` - Toggle floating for a active window
- `SUPER + C` - Move active window to center
- `SUPER + M` - Toggle maximize for a active window
- `SUPER + P` - Toggle pin for a active window
- `SUPER + CTRL + C` - Kill active window
- `SUPER + CTRL + L` - Open confirmation window for Logout
- `SUPER + CTRL + R` - Open confirmation window for Reboot
- `SUPER + CTRL + P` - Open confirmation window for Shutdown
- `SUPER + Left` - Move focus to left window
- `SUPER + Right` - Move focus to right window
- `SUPER + Up` - Move focus to up window
- `SUPER + Down` - Move focus to down window
- `SUPER + SHIFT + Left` - Move active window to left
- `SUPER + SHIFT + Right` - Move active window to right
- `SUPER + SHIFT + Up` - Move active window to up
- `SUPER + SHIFT + Down` - Move active window to down
- `SUPER + CTRL + Left` - Decrease active window width
- `SUPER + CTRL + Right` - Increase active window width
- `SUPER + CTRL + Up` - Decrease active window height
- `SUPER + CTRL + Down` - Increase active window height
- `SUPER + <1-0>` - Switch to N workspace
- `SUPER + SHIFT + <1-0>` - Move active window to N workspace
- `SUPER + MouseWheelUp` - Switch to next existing workspace
- `SUPER + MouseWheelDown` - Switch to previous existing workspace

#### Wallpapers

You can paste wallpapers to `<flake_directory>/config/wallpapers` and rebuild, or paste to `$HOME/.config/wallpapers`

#### Commands and aliases

To edit aliases edit `<flake_directory>/home/shell.nix`

- `fullClean` - full clean NixOS garbage and old generations
- `rebuild` - rebuild flake
- `cat` - alias to `bat`
- `ls` - alias to `eza --icons=always`
- `journallog file` - log journalctl to file. `file` default is `/var/log/current_boot`
- `openproject` - run script to create and open terminal/editor in project. Projects contains in `$HOME/projects`
- `randomwallpaper` - change wallpaper to random from `$HOME/.config/wallpapers`