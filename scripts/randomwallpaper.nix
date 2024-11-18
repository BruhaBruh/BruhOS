{ pkgs, vars, ... }:

pkgs.writeShellScriptBin "randomwallpaper" ''
  set -e
  
  wallpaper=$(find "${vars.wallpapersDirectory}" \( -iname "*.jpeg" -o -iname "*.jpg" -o -iname "*.png" -o -iname "*.webp" \) | shuf -n 1)

  hyprctl hyprpaper preload "$wallpaper"
  hyprctl hyprpaper wallpaper ",$wallpaper"
''
