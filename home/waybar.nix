{ pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        margin-top = 8;
        margin-bottom = 0;
        margin-left = 12;
        margin-right = 12;
        height = 24;

        modules-left = [ "custom/apps" "hyprland/language" "clock" "hyprland/workspaces" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [ "cpu" "temperature" "memory" "pulseaudio" "custom/logout" "custom/reboot" "custom/poweroff" ];

        clock = {
          format = "{:%H:%M:%S  %d.%m.%Y} ";
          tooltip = false;
          interval = 1;
        };

        cpu = {
          interval = 10;
          format = "{}% ";
          tooltip = false;
        };

        memory = {
          interval = 30;
          format = "{used:0.1f}G ";
          tooltip = false;
        };

        temperature = {
          critical-threshold = 80;
          format = "{temperatureC}°C {icon}";
          format-icons = [ "" "" "" "" "" ];
          tooltip = false;
        };

        "hyprland/language" = {
          format-en = "US";
          format-ru = "RU";
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
            default = [ "" "" "" ];
          };
          tooltip = false;
          on-click = "pavucontrol";
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
        margin: 0px;
        /* `otf-font-awesome` is required to be installed for icons */
        font-family: 'JetBrainsMono Nerd Font', monospace;
        font-weight: bold;
        font-size: 14px;
        border-radius: 9999px;
      }

      window#waybar {
        background: transparent;
      }

      window#waybar.hidden {
        opacity: 0.2;
      }

      #custom-apps,
      #language,
      #clock,
      #window,
      #cpu,
      #temperature,
      #memory,
      #pulseaudio,
      #custom-logout,
      #custom-reboot,
      #custom-poweroff {
        margin-left: 4px;
        margin-right: 4px;
        padding: 0px 8px;
        background: #cad3f5;
        color: #24273a;
      }

      #custom-apps:hover,
      #pulseaudio:hover,
      #custom-logout:hover,
      #custom-reboot:hover,
      #custom-poweroff:hover {
        opacity: 0.9;
      }

      #custom-apps {
        background: #8aadf4;
        min-width: 22px;
        padding: 0px;
        padding-right: 2px;
        transition: all .2s ease;
      }

      #clock {
        padding-right: 12px;
      }

      #workspaces {
        margin: 0px 4px;
        padding: 0px;
      }

      #workspaces button {
        padding: 0px;
        margin-left: 2px;
        margin-right: 2px;
        min-width: 24px;
        background: #494d64;
        box-shadow: inherit;
        transition: all .2s ease;
      }

      #workspaces button:hover {
        background: #5b6078;
      }

      #workspaces button.active {
        min-width: 32px;
        background: #cad3f5;
      }

      window#waybar.empty #window {
        background: transparent;
      }

      #cpu {
        padding-right: 14px;
      }

      #temperature.critical {
        background: #ed8796;
      }

      #memory {
        padding-right: 16px;
      }

      #pulseaudio {
        padding-right: 9px;
        transition: all .2s ease;
      }

      #custom-logout {
        background: #8aadf4;
        min-width: 20px;
        padding: 0px;
        padding-right: 4px;
        transition: all .2s ease;
      }

      #custom-reboot {
        background: #eed49f;
        min-width: 20px;
        padding: 0px;
        padding-right: 4px;
        transition: all .2s ease;
      }

      #custom-poweroff {
        background: #ed8796;
        min-width: 21px;
        padding: 0px;
        padding-right: 3px;
        transition: all .2s ease;
      }
    '';
  };
}
