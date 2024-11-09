{ pkgs, vars, ... }:

pkgs.writeShellScriptBin "randomwallpaper" ''
  set -e
  
  wallpaper=$(find "${vars.wallpapersDirectory}" -type f,l | shuf -n 1)

  hyprctl hyprpaper preload "$wallpaper"
  hyprctl hyprpaper wallpaper ",$wallpaper"
''
