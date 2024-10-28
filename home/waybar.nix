{ pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    # package = pkgs.waybar.overrideAttrs (oldAttrs: {
    #   mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    # });
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        margin = "0 16 -8 16";

        modules-left = [ "custom/apps" "hyprland/language" "clock" "hyprland/workspaces" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [ "temperature" "memory" "cpu" "pulseaudio" "custom/logout" "custom/reboot" "custom/poweroff" ];

        clock = {
          format = "{:%H:%M:%S %d.%m.%Y} ";
          tooltip = false;
          interval = 1;
        };

        cpu = {
          interval = 10;
          format = "{}% ";
          # max-length = 10;
        };

        memory = {
          interval = 30;
          format = "{used:0.1f}G ";
        };

        temperature = {
          # thermal-zone = 2;
          # hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
          critical-threshold = 80;
          # format-critical = "{temperatureC}°C {icon}";
          format = "{temperatureC}°C {icon}";
          format-icons = ["" "" "" "" ""];
          tooltip = false;
        };

        "hyprland/language" = {
          format-en = "US";
          format-ru = "RU";
          # min-length = 5;
          tooltip = false;
        };

        "hyprland/window" = {
          format = "{initialTitle}";
          rewrite = {
            "NekoRay.*" = "NekoRay";
            "Spotify.*" = "Spotify";
          };
          separate-outputs = true;
        };

        "hyprland/workspaces" = {
          all-outputs = true;
          format = "";
        };

        pulseaudio = {
          # scroll-step = 1; # %, can be a float
          reverse-scrolling = 1;
          format = "{volume}% {icon}  {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = " {format_source}";
          format-source = "{volume}% ";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = ["" "" ""];
          };
          # min-length = 13;
          tooltip = false;
        };

        "custom/apps" = {
          format = "󰍜";
          on-click = "rofi -show drun";
          tooltip = false;
        };

        "custom/poweroff" = {
          format = "⏻";
          on-click = "poweroff";
          tooltip = false;
        };

        "custom/reboot" = {
          format = "";
          on-click = "reboot";
          tooltip = false;
        };

        "custom/logout" = {
          format = "";
          on-click = "loginctl terminate-user $USER";
          tooltip = false;
        };
      };
    };
    style = ''
      * {
        border: none;
        border-radius: 0;
        /* `otf-font-awesome` is required to be installed for icons */
        font-family: 'JetBrainsMono Nerd Font', monospace;
        font-weight: bold;
        font-size: 14px;
        min-height: 16px;
        border-radius: 9999px;
      }

      window#waybar {
        background: transparent;
      }

      window#waybar.hidden {
        opacity: 0.2;
      }

      #custom-apps {
        margin: 8px 16px 8px 0px;
        padding: 0px 10px 0 8px;
        background: #8aadf4;
        color: #24273a;
      }

      #custom-logout {
        margin: 8px 0px 8px 16px;
        padding: 0px 12px 0 8px;
        background: #8aadf4;
        color: #24273a;
      }

      #custom-reboot {
        margin: 8px 0px 8px 16px;
        padding: 0px 12px 0 8px;
        background: #eed49f;
        color: #24273a;
      }

      #custom-poweroff {
        margin: 8px 0px 8px 16px;
        padding: 0px 12px 2px 8px;
        background: #ed8796;
        color: #fff;
      }

      #language {
        margin: 8px 16px 8px 0px;
        padding: 0px 8px;
        background: #cad3f5;
        color: #24273a;
      }

      #workspaces button {
        margin: 8px 4px;
        padding: 0px 2px;
        background: #494d64;
        box-shadow: inherit;
        transition: all .2s ease;
      }

      #workspaces button:hover {
        background: #5b6078;
      }

      #workspaces button.active {
        padding: 0px 8px;
        background: #cad3f5;
      }

      #window {
        margin: 8px 4px;
        padding: 0px 8px;
        background: #cad3f5;
        color: #24273a;
      }

      window#waybar.empty #window {
        background: transparent;
      }

      #pulseaudio {
        margin: 8px 0 8px 16px;
        padding: 0px 10px 0 8px;
        background: #cad3f5;
        color: #24273a;
      }

      #temperature {
        margin: 8px 0px 8px 0;
        padding: 0px 8px 0 8px;
        background: #cad3f5;
        color: #24273a;
      }

      #memory {
        margin: 8px 0px 8px 16px;
        padding: 0px 18px 0 8px;
        background: #cad3f5;
        color: #24273a;
      }

      #cpu {
        margin: 8px 0px 8px 16px;
        padding: 0px 14px 0 8px;
        background: #cad3f5;
        color: #24273a;
      }

      #clock {
        margin: 8px 12px 8px 0px;
        padding: 0px 10px 0 8px;
        background: #cad3f5;
        color: #24273a;
      }
    '';
  };
}
