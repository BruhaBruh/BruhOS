{ pkgs, ... }:

pkgs.writeShellScriptBin "audiocycle" ''
  set -e
  
  SINKS=($(pactl list short sinks | awk '{print $2}'))

  CURRENT_SINK=$(pactl get-default-sink)

  CURRENT_INDEX=-1
  for i in "''${!SINKS[@]}"; do
    if [[ "''${SINKS[$i]}" == "$CURRENT_SINK" ]]; then
      CURRENT_INDEX=$i
      break
    fi
  done

  if (( CURRENT_INDEX == -1 )); then
    NEXT_INDEX=0
  else
    NEXT_INDEX=$(( (CURRENT_INDEX + 1) % ''${#SINKS[@]} ))
  fi

  NEXT_SINK="''${SINKS[$NEXT_INDEX]}"
  pactl set-default-sink "$NEXT_SINK"

  pactl list short sink-inputs | awk '{print $1}' | while read input; do
    pactl move-sink-input "$input" "$NEXT_SINK"
  done

  echo "current: $NEXT_SINK"
''
