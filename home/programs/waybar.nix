{ pkgs, lib, ... }:

let
  spotifydata = pkgs.writeShellScriptBin "spotifydata" ''
    snore() {
      local IFS
      [[ -n "''${_snore_fd:-}" ]] || exec {_snore_fd}<> <(:)
      read -r ''${1:+-t "$1"} -u $_snore_fd || :
    }

    DELAY=0.2

    while snore $DELAY; do
      if ! sp status > /dev/null 2>&1; then
        printf '{"class": "offline"}\n'
        continue
      fi

      status="playing"
      if [ "$(sp status)" = "Paused" ]; then
        status="paused"
      fi

      artist="$(sp metadata | grep artist | cut -d "|" -f 2)"
      track="$(sp metadata | grep title | cut -d "|" -f 2)"

      text="''${artist} - ''${track}"
      if [[ "''${artist}" = "" ]]; then
        text="''${track}"
      fi
      if [[ "''${artist}" = "" && "''${track}" = "" ]]; then
        text=""
      fi

      if [[ "''${artist}" = "" && "''${track}" = "Advertisement" ]]; then
        status="ad-''${status}"
      fi

      printf "{\"text\": \"''${text}\", \"artist\": \"''${artist}\", \"track\": \"''${track}\", \"class\": \"''${status}\", \"alt\": \"''${status}\"}\n"
    done
  '';
  audiodata = pkgs.writeShellScriptBin "audiodata" ''
    snore() {
      local IFS
      [[ -n "''${_snore_fd:-}" ]] || exec {_snore_fd}<> <(:)
      read -r ''${1:+-t "$1"} -u $_snore_fd || :
    }

    DELAY=0.2

    while snore $DELAY; do
      current_sink=$(pactl get-default-sink)

      left_volume=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | tr -d '%')
      right_volume=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $12}' | tr -d '%')

      mono_volume="$(( (left_volume + right_volume) / 2 ))"

      printf "{\"text\": \"''${mono_volume}%%\", \"current_sink\": \"''${current_sink}\", \"class\": \"''${current_sink}\", \"alt\": \"''${current_sink}\"}\n"
    done
  '';
in
{
  programs.waybar = {
    enable = true;
    systemd = {
      enable = false;
      target = "hyprland-session.target";
    };
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        margin-top = 8;
        margin-bottom = 0;
        margin-left = 8;
        margin-right = 8;
        height = 28;

        modules-left = [ "custom/apps" "hyprland/workspaces" ];
        modules-center = [ "custom/wallpaper" "hyprland/window" "custom/audio" ];
        modules-right = [ "custom/spotify-prev" "custom/spotify" "custom/spotify-next" "custom/time" "custom/date" "custom/powermenu" ];

        "custom/apps" = {
          format = "";
          on-click = "rofi -show drun -theme $HOME/.config/rofi/launcher.rasi";
          tooltip = false;
        };

        "custom/wallpaper" = {
          format = "";
          on-click = "wallpaper";
          tooltip = false;
        };

        "hyprland/workspaces" = {
          all-outputs = true;
          format = "{icon}";
        };

        "hyprland/window" = {
          format = "{initialTitle}";
          rewrite = {
            "NekoRay.*" = "NekoRay";
            "Spotify.*" = "Spotify";
          };
          separate-outputs = true;
        };

        "custom/spotify-prev" = {
          format = "{icon}";
          format-icons = {
            playing = "";
            paused = "";
            ad-playing = "";
            ad-paused = "";
          };
          hide-empty-text = true;
          escape = true;
          return-type = "json";
          restart-interval = 1;
          on-click = "sp prev";
          exec = "${spotifydata}/bin/spotifydata 2> /dev/null";
          exec-on-event = false;
        };

        "custom/spotify" = {
          format = "{} {icon}";
          format-icons = {
            playing = "";
            paused = "";
            ad-playing = "";
            ad-paused = "";
          };
          hide-empty-text = true;
          escape = true;
          return-type = "json";
          restart-interval = 1;
          on-click = "sp play";
          on-click-right = "hyprctl dispatch focuswindow 'initialtitle:^(.*Spotify.*)$'";
          exec = "${spotifydata}/bin/spotifydata 2> /dev/null";
          exec-on-event = false;
        };

        "custom/spotify-next" = {
          format = "{icon}";
          format-icons = {
            playing = "";
            paused = "";
            ad-playing = "";
            ad-paused = "";
          };
          hide-empty-text = true;
          escape = true;
          return-type = "json";
          restart-interval = 1;
          on-click = "sp next";
          exec = "${spotifydata}/bin/spotifydata 2> /dev/null";
          exec-on-event = false;
        };

        "custom/audio" = {
          format = "{} {icon}";
          format-icons = {
            "alsa_output.pci-0000_06_00.4.analog-stereo" = "";
            "alsa_output.pci-0000_04_00.1.hdmi-stereo" = "";
          };
          hide-empty-text = true;
          escape = true;
          return-type = "json";
          restart-interval = 1;
          on-click = "audiocycle";
          on-scroll-up = "audiovolume inc";
          on-scroll-down = "audiovolume dec";
          exec = "${audiodata}/bin/audiodata 2> /dev/null";
          exec-on-event = false;
        };

        "custom/time" = {
          exec = "date +\"%H:%M:%S \"";
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

        "custom/uptime" = {
          exec = "uptime | sed -E 's/.*up +([^,]+),.*/\\1/'";
          interval = 1;
          escape = true;
          tooltip = false;
        };

        "custom/powermenu" = {
          format = "";
          on-click = "powermenu";
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
        font-weight: bolder;
        font-size: 14px;
        border-radius: 9999px;
      }

      window#waybar {
        background: transparent;
      }

      #custom-apps,
      #custom-wallpaper,
      #window,
      #custom-spotify-prev,
      #custom-spotify,
      #custom-spotify-next,
      #custom-audio,
      #custom-time,
      #custom-date,
      #custom-uptime,
      #custom-powermenu {
        margin-left: 8px;
        margin-right: 8px;
        padding: 0px 12px;
        background: @base;
        color: @text;
      }

      #custom-apps {
        background: linear-gradient(
          45deg,
          @blue 0%,
          @sapphire 13%,
          @sky 26%,
          @lavender 34%,
          @mauve 49%,
          @blue 65%,
          @sapphire 77%,
          @lavender 88%,
          @mauve 95%
        );
        color: @base;
        background-size: 500% 500%;
        animation: gradient 7s linear infinite;
        padding-right: 16px;
      }

      #custom-wallpaper {
        background: linear-gradient(
          45deg,
          @green 0%,
          @teal 13%,
          @green 26%,
          @teal 34%,
          @green 49%,
          @teal 65%,
          @green 77%,
          @teal 88%,
          @green 95%
        );
        color: @base;
        background-size: 500% 500%;
        animation: gradient 7s linear infinite;
        padding-right: 18px;
      }

      #workspaces {
        margin-left: 8px;
        margin-right: 8px;
      }

      #workspaces button {
        margin-left: 4px;
        margin-right: 4px;
        padding: 0px 8px;
        background: @text;
        color: @base;
        transition: all 0.2s ease-in-out;
      }

      #workspaces button:hover {
        background: @subtext1;
      }

      #workspaces button.active {
        padding: 0px 16px;
        background: radial-gradient(
          circle,
          @mauve 0%,
          @lavender 12%,
          @yellow 19%,
          @mauve 20%,
          @mauve 24%,
          @teal 36%,
          @lavender 37%,
          @sapphire 48%,
          @text 52%,
          @blue 52%,
          @blue 59%,
          @green 66%,
          @lavender 67%,
          @lavender 68%,
          @subtext1 77%,
          @green 78%,
          @blue 82%,
          @lavender 83%,
          @blue 90%,
          @blue 100%
        );
        background-size: 400% 400%;
        animation: gradient_f 20s ease-in-out infinite;
      }

      #window {
        color: @base;
        background: radial-gradient(
          circle,
          @green 0%,
          @teal 21%, 
          @yellow 34%,
          @mauve 35%, 
          @sapphire 59%, 
          @green 74%, 
          @lavender 74%, 
          @blue 100%
        );
        background-size: 400% 400%;
        animation: gradient_f 4s ease infinite;
        transition: all 0.1s ease-in-out;
      }

      window#waybar.empty #window {
        padding: 0;
      }

      #custom-spotify-prev {
        margin-right: 0px;
        padding-right: 16px;
      }

      #custom-spotify {
        padding-right: 14px;
        transition: all 0.2s ease-in-out;
      }

      #custom-spotify-next {
        margin-left: 0px;
        padding-right: 16px;
      }


      #custom-spotify-prev,
      #custom-spotify,
      #custom-spotify-next {
        background: @text;
        color: @base;
      }

      #custom-spotify.playing {
        color: @base;
        background: linear-gradient(
          70deg,
          @mauve 0%,
          @lavender 12%,
          @yellow 19%,
          @mauve 20%,
          @mauve 24%,
          @teal 36%,
          @lavender 37%,
          @sapphire 48%,
          @text 52%,
          @blue 52%,
          @blue 59%,
          @green 66%,
          @lavender 67%,
          @lavender 68%,
          @subtext1 77%,
          @green 78%,
          @blue 82%,
          @lavender 83%,
          @blue 90%,
          @blue 100%
        );
        background-size: 400% 400%;
        animation: gradient_f 20s ease-in-out infinite;
      }

      #custom-spotify-prev.ad-playing,
      #custom-spotify.ad-playing,
      #custom-spotify-next.ad-playing,
      #custom-spotify-prev.ad-paused,
      #custom-spotify.ad-paused,
      #custom-spotify-next.ad-paused {
        opacity: 0.5;
      }

      #custom-audio {
        background: linear-gradient(
          45deg,
          @green 0%,
          @teal 13%,
          @green 26%,
          @teal 34%,
          @green 49%,
          @teal 65%,
          @green 77%,
          @teal 88%,
          @green 95%
        );
        color: @base;
        background-size: 500% 500%;
        animation: gradient 7s linear infinite;
        padding-right: 18px;
      }

      #custom-time {
        background: @text;
        color: @base;
        padding-right: 18px;
      }

      #custom-date {
        background: @text;
        color: @base;
        padding-right: 16px;
      }

      #custom-uptime {
        background: @text;
        color: @base;
      }

      #custom-powermenu {
        background: linear-gradient(
          45deg,
          @red 0%,
          @maroon 13%,
          @red 26%,
          @maroon 34%,
          @red 49%,
          @maroon 65%,
          @red 77%,
          @maroon 88%,
          @red 95%
        );
        color: @base;
        background-size: 500% 500%;
        animation: gradient 7s linear infinite;
        padding-right: 17px;
      }

      @keyframes gradient {
        0% {
          background-position: 0% 50%;
        }
        50% {
          background-position: 100% 30%;
        }
        100% {
          background-position: 0% 50%;
        }
      }

      @keyframes gradient_f {
        0% {
          background-position: 0% 200%;
        }
        50% {
          background-position: 200% 0%;
        }
        100% {
          background-position: 400% 200%;
        }
      }
    '';
  };
}
