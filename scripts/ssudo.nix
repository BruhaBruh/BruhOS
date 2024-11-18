{ pkgs, vars, ... }:

pkgs.writeShellScriptBin "ssudo" ''
  set -e
  
  if [[ -n "$WAYLAND_DISPLAY" && -n "$DISPLAY" ]]; then
    sudo -A "$@"
  else
    sudo "$@"
  fi
''
