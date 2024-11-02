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

        modules-left = [ "custom/apps" "hyprland/language" "custom/time" "custom/date" "hyprland/workspaces" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [ "cpu" "temperature" "memory" "pulseaudio" "custom/logout" "custom/reboot" "custom/poweroff" ];

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

        "custom/time" = {
          exec = "date +\"%H:%M:%S \"";
          interval = 1;
          escape = true;
          tooltip = false;
        };

        "custom/date" = {
          exec = "date +\"%d.%m.%Y \"";
          interval = 1;
          escape = true;
          tooltip = false;
        };
      };
    };
    style = ''
      @define-color rosewater #f4dbd6;
      @define-color flamingo #f0c6c6;
      @define-color pink #f5bde6;
      @define-color mauve #c6a0f6;
      @define-color red #ed8796;
      @define-color maroon #ee99a0;
      @define-color peach #f5a97f;
      @define-color yellow #eed49f;
      @define-color green #a6da95;
      @define-color teal #8bd5ca;
      @define-color sky #91d7e3;
      @define-color sapphire #7dc4e4;
      @define-color blue #8aadf4;
      @define-color lavender #b7bdf8;
      @define-color text #cad3f5;
      @define-color subtext1 #b8c0e0;
      @define-color subtext0 #a5adcb;
      @define-color overlay2 #939ab7;
      @define-color overlay1 #8087a2;
      @define-color overlay0 #6e738d;
      @define-color surface2 #5b6078;
      @define-color surface1 #494d64;
      @define-color surface0 #363a4f;
      @define-color base #24273a;
      @define-color mantle #1e2030;
      @define-color crust #181926;

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
      #custom-time,
      #custom-date,
      #window,
      #custom-notification,
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
        background: @text;
        color: @base;
      }

      #custom-apps:hover,
      #pulseaudio:hover,
      #custom-logout:hover,
      #custom-reboot:hover,
      #custom-poweroff:hover {
        opacity: 0.9;
      }

      #custom-apps {
        background: @blue;
        min-width: 22px;
        padding: 0px;
        padding-right: 2px;
        transition: all .2s ease;
      }

      #custom-time {
        padding-right: 10px;
      }

      #custom-date {
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
        background: @base;
        box-shadow: inherit;
        transition: all .2s ease;
      }

      #workspaces button:hover {
        background: @surface0;
      }

      #workspaces button.active {
        min-width: 32px;
        background: @text;
      }

      window#waybar.empty #window {
        background: transparent;
      }

      #cpu {
        padding-right: 14px;
      }

      #temperature.critical {
        background: @red;
      }

      #memory {
        padding-right: 16px;
      }

      #pulseaudio {
        padding-right: 9px;
        transition: all .2s ease;
      }

      #custom-logout {
        background: @blue;
        min-width: 20px;
        padding: 0px;
        padding-right: 4px;
        transition: all .2s ease;
      }

      #custom-reboot {
        background: @yellow;
        min-width: 20px;
        padding: 0px;
        padding-right: 4px;
        transition: all .2s ease;
      }

      #custom-poweroff {
        background: @red;
        min-width: 21px;
        padding: 0px;
        padding-right: 3px;
        transition: all .2s ease;
      }
    '';
  };
}
