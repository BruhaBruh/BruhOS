{ pkgs, ... }:

pkgs.writeShellScriptBin "audiovolume" ''
  set -e
  
  if [ "$#" -ne 1 ]; then
    echo "Usage: $0 {inc|dec}"
    exit 1
  fi

  CURRENT_SINK=$(pactl get-default-sink)

  CURRENT_VOLUME=$(pactl get-sink-volume "$CURRENT_SINK" | awk '{print $5}' | tr -d '%')

  if [ "$1" == "inc" ]; then
    NEW_VOLUME=$((CURRENT_VOLUME + 5))
    if [ "$NEW_VOLUME" -gt 100 ]; then
      NEW_VOLUME=100
    fi
  elif [ "$1" == "dec" ]; then
    NEW_VOLUME=$((CURRENT_VOLUME - 5))
    if [ "$NEW_VOLUME" -lt 0 ]; then
      NEW_VOLUME=0
    fi
  else
    echo "Invalid command. Use 'inc' for increase or 'dec' for decrease volume."
    exit 1
  fi

  pactl set-sink-volume "$CURRENT_SINK" "''${NEW_VOLUME}%"

  echo "current volume: ''${NEW_VOLUME}%"
''
