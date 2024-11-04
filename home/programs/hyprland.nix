{ ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    settings = {
      "$mainMod" = "SUPER";

      "$ROSEWATER" = "rgb(f4dbd6)";
      "$ROSEWATER_ALPHA" = "f4dbd6";

      "$FLAMINGO" = "rgb(f0c6c6)";
      "$FLAMINGO_ALPHA" = "f0c6c6";

      "$PINK" = "rgb(f5bde6)";
      "$PINK_ALPHA" = "f5bde6";

      "$MAUVE" = "rgb(c6a0f6)";
      "$MAUVE_ALPHA" = "c6a0f6";

      "$RED" = "rgb(ed8796)";
      "$RED_ALPHA" = "ed8796";

      "$MAROON" = "rgb(ee99a0)";
      "$MAROON_ALPHA" = "ee99a0";

      "$PEACH" = "rgb(f5a97f)";
      "$PEACH_ALPHA" = "f5a97f";

      "$YELLOW" = "rgb(eed49f)";
      "$YELLOW_ALPHA" = "eed49f";

      "$GREEN" = "rgb(a6da95)";
      "$GREEN_ALPHA" = "a6da95";

      "$TEAL" = "rgb(8bd5ca)";
      "$TEAL_ALPHA" = "8bd5ca";

      "$SKY" = "rgb(91d7e3)";
      "$SKY_ALPHA" = "91d7e3";

      "$SAPPHIRE" = "rgb(7dc4e4)";
      "$SAPPHIRE_ALPHA" = "7dc4e4";

      "$BLUE" = "rgb(8aadf4)";
      "$BLUE_ALPHA" = "8aadf4";

      "$LAVENDER" = "rgb(b7bdf8)";
      "$LAVENDER_ALPHA" = "b7bdf8";

      "$TEXT" = "rgb(cad3f5)";
      "$TEXT_ALPHA" = "cad3f5";

      "$SUBTEXT1" = "rgb(b8c0e0)";
      "$SUBTEXT1_ALPHA" = "b8c0e0";

      "$SUBTEXT0" = "rgb(a5adcb)";
      "$SUBTEXT0_ALPHA" = "a5adcb";

      "$OVERLAY2" = "rgb(939ab7)";
      "$OVERLAY2_ALPHA" = "939ab7";

      "$OVERLAY1" = "rgb(8087a2)";
      "$OVERLAY1_ALPHA" = "8087a2";

      "$OVERLAY0" = "rgb(6e738d)";
      "$OVERLAY0_ALPHA" = "6e738d";

      "$SURFACE2" = "rgb(5b6078)";
      "$SURFACE2_ALPHA" = "5b6078";

      "$SURFACE1" = "rgb(494d64)";
      "$SURFACE1_ALPHA" = "494d64";

      "$SURFACE0" = "rgb(363a4f)";
      "$SURFACE0_ALPHA" = "363a4f";

      "$BASE" = "rgb(24273a)";
      "$BASE_ALPHA" = "24273a";

      "$MANTLE" = "rgb(1e2030)";
      "$MANTLE_ALPHA" = "1e2030";

      "$CRUST" = "rgb(181926)";
      "$CRUST_ALPHA" = "181926";

      monitor = ",1920x1080@144,0x0,1";

      env = [
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "XCURSOR_THEME,catppuccin-macchiato-dark-cursors"
        "XCURSOR_SIZE,24"
        "QT_QPA_PLATFORM,wayland"
        "XDG_SCREENSHOTS_DIR,~/screens"
      ];

      debug = {
        disable_logs = false;
        enable_stdout_logs = true;
      };

      input = {
        kb_layout = "us,ru";
        kb_variant = "lang";
        kb_options = "grp:alt_shift_toggle";

        follow_mouse = 2;

        touchpad = {
          natural_scroll = false;
        };

        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
      };

      general = {
        gaps_in = 8;
        gaps_out = 16;
        border_size = 2;
        resize_on_border = true;
        "col.active_border" = "rgba($MAUVE_ALPHAff) rgba($BLUE_ALPHAff) rgba($TEAL_ALPHAff) 10deg";
        "col.inactive_border" = "rgba($OVERLAY0_ALPHA5a)";

        layout = "dwindle";
      };

      decoration = {
        rounding = 8;

        blur = {
          enabled = true;
          size = 16;
          passes = 2;
          new_optimizations = true;
        };

        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba($SURFACE0_ALPHAee)";
      };

      animations = {
        enabled = true;

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        # bezier = "myBezier, 0.33, 0.82, 0.9, -0.08";

        animation = [
          "windows,     1, 7,  myBezier"
          "windowsOut,  1, 7,  default, popin 80%"
          "border,      1, 10, default"
          "borderangle, 1, 8,  default"
          "fade,        1, 7,  default"
          "workspaces,  1, 6,  default"
        ];
      };

      dwindle = {
        pseudotile = true; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true; # you probably want this
      };

      master = {
        new_status = "master";
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 3;
        workspace_swipe_invert = false;
        workspace_swipe_distance = 200;
        workspace_swipe_forever = true;
      };

      cursor = {
        no_warps = true;
      };

      misc = {
        animate_manual_resizes = true;
        animate_mouse_windowdragging = true;
        enable_swallow = true;
        render_ahead_of_time = false;
        disable_hyprland_logo = true;
        font_family = "Inter";
      };

      windowrule = [
        "float, ^(imv)$"
        "float, ^(mpv)$"
      ];

      windowrulev2 = [
        "workspace 1,initialTitle:^(Zen Browser)$"
        "workspace 2,initialTitle:^(Visual Studio Code)$"
        "workspace 3,initialTitle:^(Telegram)$"
        "workspace 9,initialTitle:^(Spotify)$"
        "workspace 10,initialClass:^(nekoray)$"

        "float,initialTitle:^Картинка в картинке$"
        "size 450 254,initialTitle:^Картинка в картинке$"
        "move 100%-w-16 100%-w-16,initialTitle:^Картинка в картинке$"
        "pin,initialTitle:^Картинка в картинке$"
      ];

      exec-once = [
        # Random Wallpaper Every 15 minutes
        "systemctl --user restart random-wallpaper.service"
        "systemctl --user restart random-wallpaper.timer"

        "waybar"

        "[workspace 1 silent] zen"
        "[workspace 2 silent] code"
        "[workspace 3 silent] telegram-desktop"
        "[workspace 9 silent] spotify"
        "[workspace 10 silent] nekoray"
      ];

      bind = [
        "$mainMod, Q, exec, foot"
        "$mainMod, R, exec, rofi -show drun"
        "$mainMod, E, exec, thunar"
        "$mainMod, F, togglefloating"
        "$mainMod, C, centerwindow"
        "$mainMod, M, fullscreen, 1"
        "$mainMod, P, pin"

        "$mainMod CTRL, C, killactive,"
        "$mainMod CTRL, L, exec, exit"
        "$mainMod CTRL, R, exec, reboot"
        "$mainMod CTRL, P, exec, poweroff"

        # Move focus with mainMod + arrow keys
        "$mainMod, left,  movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up,    movefocus, u"
        "$mainMod, down,  movefocus, d"

        # Moving windows
        "$mainMod SHIFT, left,  swapwindow, l"
        "$mainMod SHIFT, right, swapwindow, r"
        "$mainMod SHIFT, up,    swapwindow, u"
        "$mainMod SHIFT, down,  swapwindow, d"

        # Window resizing                     X  Y
        "$mainMod CTRL, left,  resizeactive, -60 0"
        "$mainMod CTRL, right, resizeactive,  60 0"
        "$mainMod CTRL, up,    resizeactive,  0 -60"
        "$mainMod CTRL, down,  resizeactive,  0  60"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspacesilent, 1"
        "$mainMod SHIFT, 2, movetoworkspacesilent, 2"
        "$mainMod SHIFT, 3, movetoworkspacesilent, 3"
        "$mainMod SHIFT, 4, movetoworkspacesilent, 4"
        "$mainMod SHIFT, 5, movetoworkspacesilent, 5"
        "$mainMod SHIFT, 6, movetoworkspacesilent, 6"
        "$mainMod SHIFT, 7, movetoworkspacesilent, 7"
        "$mainMod SHIFT, 8, movetoworkspacesilent, 8"
        "$mainMod SHIFT, 9, movetoworkspacesilent, 9"
        "$mainMod SHIFT, 0, movetoworkspacesilent, 10"

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        # Keyboard backlight
        "$mainMod, F3, exec, brightnessctl -d *::kbd_backlight set +33%"
        "$mainMod, F2, exec, brightnessctl -d *::kbd_backlight set 33%-"

        # Volume and Media Control
        ", XF86AudioRaiseVolume, exec, pamixer -i 5 "
        ", XF86AudioLowerVolume, exec, pamixer -d 5 "
        ", XF86AudioMute, exec, pamixer -t"
        ", XF86AudioMicMute, exec, pamixer --default-source -m"

        # Brightness control
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%- "
        ", XF86MonBrightnessUp, exec, brightnessctl set +5% "

        # Screenshot
        ''$mainMod, S, exec, grim - | wl-copy && notify-send "Screenshot" "Fullscreen screenshot saved to clipboard"''
        ''$mainMod SHIFT, S, exec, grim -g "$(slurp)" - | wl-copy && notify-send "Screenshot" "Screenshot saved to clipboard"''

        # Waybar
        "$mainMod, B, exec, pkill -SIGUSR1 waybar"
        "$mainMod, W, exec, pkill -SIGUSR2 waybar"
      ];

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };
}
