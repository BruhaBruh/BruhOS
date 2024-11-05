{ pkgs, vars, ... }:

{
  script = pkgs.writeShellScriptBin "randomwallpaper" ''
    wallpaper=$(find "${vars.wallpapersDirectory}" -type f,l | shuf -n 1)

    hyprctl hyprpaper preload "$wallpaper"
    hyprctl hyprpaper wallpaper ",$wallpaper"
  '';
}
