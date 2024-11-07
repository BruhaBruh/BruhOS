{ pkgs, vars, ... }:

{
  script = pkgs.writeShellScriptBin "powermenu" ''
    uptime="`uptime | sed -E 's/.*up +([^,]+),.*/\1/'`"
  
    shutdown=''
    reboot=''
    logout=''
    yes=''
    no=''

    rofi_cmd() {
      rofi -dmenu \
        -p "$uptime" \
        -mesg "${vars.hostName}" \
        -theme $HOME/.config/rofi/power-menu.rasi
    }

    confirm_cmd() {
      rofi -dmenu \
        -p "''${1}" \
        -mesg 'Are you Sure?' \
        -theme $HOME/.config/rofi/confirmation.rasi
    }

    confirm_exit() {
      echo -e "$yes\n$no" | confirm_cmd $1
    }

    run_rofi() {
      echo -e "$logout\n$reboot\n$shutdown" | rofi_cmd
    }

    run_cmd() {
      selected="$(confirm_exit $2)"
      if [[ "$selected" == "$yes" ]]; then
        if [[ $1 == '--shutdown' ]]; then
          systemctl poweroff
        elif [[ $1 == '--reboot' ]]; then
          systemctl reboot
        elif [[ $1 == '--logout' ]]; then
          hyprctl dispatch exit
        fi
      else
        exit 0
      fi
    }

    chosen="$(run_rofi)"
    case ''${chosen} in
        $shutdown)
        run_cmd --shutdown Shutdown
            ;;
        $reboot)
        run_cmd --reboot Reboot
            ;;
        $logout)
        run_cmd --logout Logout
            ;;
    esac
  '';
}

