{ pkgs, vars, ... }:

pkgs.writeShellScriptBin "wallpaper" ''
  set -e

  rofi_cmd() {
    find "${vars.wallpapersDirectory}" \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) -exec basename {} \; \
      | sort \
      | while read -r A ; do  echo -en "$A\x00icon\x1f""${vars.wallpapersDirectory}"/"$A\n" ; done \
      | rofi -dmenu \
        -theme $HOME/.config/rofi/wallpaper.rasi
  }

  wallpaper=$(rofi_cmd)

  hyprctl hyprpaper preload "${vars.wallpapersDirectory}/$wallpaper"
  hyprctl hyprpaper wallpaper ",${vars.wallpapersDirectory}/$wallpaper"
''
