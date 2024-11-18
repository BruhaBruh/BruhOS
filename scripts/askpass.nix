{ pkgs, vars, ... }:

pkgs.writeShellScriptBin "askpass" ''
  set -e
  
  rofi -dmenu \
    -password \
    -no-fixed-num-lines \
    -p "$(printf "$1" | sed s/://)" \
    -theme $HOME/.config/rofi/askpass.rasi
''
