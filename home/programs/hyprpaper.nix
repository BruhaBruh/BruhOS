{ pkgs, vars, scripts, ... }:

let
  serviceInterval = toString vars.wallpaper.service.interval;

  runRandomWallpaper =
    if vars.wallpaper.service.enabled then [
      "${scripts.randomwallpaper}/bin/randomwallpaper"
    ] else [
      "exit 0"
    ];
  defaultWallpaper = "${vars.wallpaper.directory.destinationFull}/${vars.wallpaper.default}";
in
{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = "${defaultWallpaper}";
      wallpaper = ", ${defaultWallpaper}";
    };
  };

  home.file."${vars.wallpaper.directory.destination}" = {
    source = vars.wallpaper.directory.source;
    recursive = true;
  };

  systemd.user = {
    timers.random-wallpaper = {
      Unit = {
        Description = "Change wallpaper every 15 minutes";
      };
      Timer = {
        OnCalendar = "*:0/${serviceInterval}";
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
        ExecStart = runRandomWallpaper;
      };
    };
  };
}

