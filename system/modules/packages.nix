{ pkgs, pkgs-stable, vars, system, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Desktop Apps
    chromium
    inputs.zen-browser.packages.${system}.default
    telegram-desktop
    vesktop
    bitwarden-desktop
    spotify
    pkgs-stable.obs-studio
    libreoffice

    # Minecraft
    prismlauncher
    glfw-wayland-minecraft

    # VPN
    nekoray

    # Docker
    docker
    docker-compose

    # CLI
    curl
    wget
    git
    fastfetch
    openssl
    pciutils
    vim
    btrfs-progs
    cpufrequtils
    libappindicator
    libnotify
    btop
    jq
    zip
    unzip
    nixpkgs-fmt
    gh
    spotify-cli-linux

    # XDG
    xdg-utils
    xdg-user-dirs

    # Wayland
    xwayland
    wl-clipboard
    cliphist
    wlr-randr
    wlogout
    wallust

    # WMs
    hyprland
    hyprpicker
    hyprland-protocols
    hyprpaper
    waybar
    gnome-system-monitor
    hyprcursor
    imagemagick
    libsForQt5.qtstyleplugin-kvantum
    networkmanagerapplet
    nwg-look
    nvtopPackages.full
    pyprland
    libsForQt5.qt5ct
    qt5.qtwayland
    qt6ct
    qt6.qtwayland
    qt6Packages.qtstyleplugin-kvantum
    rofi-wayland
    slurp
    swaynotificationcenter
    yad
    yt-dlp

    # Sound
    pipewire
    pulseaudio
    pamixer
    pavucontrol
    playerctl

    # System Packages
    fzf
    baobab
    clang
    duf
    eza
    bat
    lsof
    ffmpeg
    glib
    gsettings-qt
    killall
    (mpv.override { scripts = [ mpvScripts.mpris ]; })
    polkit_gnome
    libinput
    xorg.xcursorthemes
    base16-schemes

    # Other
    ags
    cava
    eog
    file-roller
    grim
    gtk-engine-murrine
    inxi
    inter
  ];

  programs = {
    chromium.enable = true;
    waybar.enable = true;
    git.enable = true;
    zsh.enable = true;
    obs-studio = {
      enable = true;
      plugins = with pkgs-stable.obs-studio-plugins; [
        wlrobs
        obs-vaapi
        obs-vkcapture
        obs-pipewire-audio-capture
      ];
    };
    nm-applet.indicator = true;
    thunar.enable = true;
    thunar.plugins = with pkgs.xfce; [
      exo
      mousepad
      thunar-archive-plugin
      thunar-volman
      tumbler
      xfce4-settings
    ];
    xwayland.enable = true;
    dconf.enable = true;
    seahorse.enable = true;
    fuse.userAllowOther = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  services = {
    resolved.enable = true;

    greetd = {
      enable = true;
      vt = 3;
      settings = {
        initial_session = {
          command = "${pkgs.hyprland}/bin/Hyprland";
          user = "${vars.username}";
        };
        default_session = {
          user = "${vars.username}";
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --remember --remember-user-session --asterisks --time --cmd ${pkgs.hyprland}/bin/Hyprland";
        };
      };
    };

    smartd = {
      enable = false;
      autodetect = true;
    };

    gvfs.enable = true;

    udev.enable = true;
    envfs.enable = true;
    dbus.enable = true;

    rpcbind.enable = false;
    nfs.server.enable = false;

    openssh.enable = true;

    fwupd.enable = true;

    upower.enable = true;
  };
}
