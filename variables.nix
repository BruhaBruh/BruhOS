rec {
  # flakeDirectory
  flakeDirectory = "/home/bruhabruh/.dotfiles";
  # hostName
  hostName = "desktop";
  # username
  username = "bruhabruh";

  # timeZone
  timeZone = "Asia/Yekaterinburg";

  locale = {
    # locale.default
    default = "en_US.UTF-8";
    # locale.extra
    extra = "ru_RU.UTF-8";
    supported = [
      # locale.supported[0]
      "en_US.UTF-8/UTF-8"
      # locale.supported[1]
      "ru_RU.UTF-8/UTF-8"
    ];
  };

  git = {
    # git.username
    username = "BruhaBruh";
    # git.email
    email = "drugsho.jaker@gmail.com";
    # git.defaultBranch
    defaultBranch = "main";
  };

  apple = {
    cursors = {
      # apple.cursors.enabled
      enabled = true;
    };
    icons = {
      # apple.icons.enabled
      enabled = true;
    };
  };

  wallpaper = {
    # wallpaper.default
    default = "forest.jpg";

    directory = {
      # wallpaper.directory.source
      source = ./config/wallpapers;
      # wallpaper.directory.destination
      destination = ".config/wallpapers";
      # wallpaper.directory.destinationFull
      destinationFull = "/home/${username}/${wallpaper.directory.destination}";
    };

    service = {
      # wallpaper.service.enabled
      enabled = false;
      # wallpaper.service.interval 
      interval = 1;
    };
  };

  proxy = {
    # proxy.enabled
    enabled = false;
  };
}
