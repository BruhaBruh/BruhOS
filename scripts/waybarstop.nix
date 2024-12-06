{ pkgs, ... }:

pkgs.writeShellScriptBin "waybarstop" ''
  set -e
  
  while [ "$(systemctl --user show -p ActiveState --value waybar.service)" != "active" ]; do
    sleep 0.1
  done

  systemctl --user stop waybar.service
''
