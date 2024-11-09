{ pkgs, ... }:

pkgs.writeShellScriptBin "journallog" ''
  set -e

  log=''${1:-"/var/log/current_boot"}

  mkdir -p "$(dirname "$log")"
  if [[ -f "$log" ]]; then
    backupname=$(date "+%H-%M-%S-%d-%m-%Y")
    mv "$log" "$log-$backupname"
  fi
  touch $log

  log_uptime() {
    while true; do
      echo "Uptime: $(uptime)" >> "$log"
      sleep 60
    done
  }

  log_uptime & sudo journalctl -f -o short-iso | tee -a "$log"
''
