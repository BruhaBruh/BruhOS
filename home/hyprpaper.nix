{ pkgs, vars, ... }:

let
  configWallpapersDirectory = ../config/wallpapers;
  wallpapersDirectory = "/home/${vars.username}/.config/wallpapers";
  defaultWallpaper = "${wallpapersDirectory}/minimalistic/darker_unicat.png";
  randomWallpaperScript = ''
    wallpaper="${wallpapersDirectory}/minimalistic/darker_unicat.png"

    folders=("custom" "flatppuccin" "gradients" "minimalistic" "os")

    selected_folder=''${folders[$((RANDOM % ''${#folders[@]}))]}

    wallpaper=$(find "${wallpapersDirectory}/$selected_folder" -type l | shuf -n 1)

    hyprctl hyprpaper preload "$wallpaper"
    hyprctl hyprpaper wallpaper ",$wallpaper"
  '';
in
{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = "${defaultWallpaper}";
      wallpaper = ", ${defaultWallpaper}";
    };
  };

  home.packages = with pkgs; [
    (pkgs.writeShellScriptBin "random_wallpaper" ''${randomWallpaperScript}'')
  ];

  home.file.".config/wallpapers" = {
    source = configWallpapersDirectory;
    recursive = true;
  };

  systemd.user = {
    timers.random-wallpaper = {
      Unit = {
        Description = "Change wallpaper every 15 minutes";
      };
      Timer = {
        OnCalendar = "*:0/15";
        Unit = "random-wallpaper.service";
      };
      Install = {
        WantedBy = [ "timers.target" ];
      };
    };

    services.random-wallpaper = {
      Unit = {
        Description = "Service to change wallpaper";
      };
      Service = {
        Type = "oneshot";
        ExecStart = "${pkgs.writeShellScript "random_wallpaper" ''${randomWallpaperScript}''}";
      };
    };
  };
}
