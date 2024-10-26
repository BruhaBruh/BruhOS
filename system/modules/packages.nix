{ pkgs, vars, system, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Desktop Apps
    chromium
    inputs.zen-browser.packages.${system}.default
    telegram-desktop
    vscode
    vesktop
    bitwarden-desktop
    spotify

    # VPN
    nekoray

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

    # XDG
    xdg-utils
    xdg-user-dirs
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland

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
    swappy
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
    baobab
    clang
    duf
    eza
    bat
    ffmpeg
    glib
    gsettings-qt
    killall
    (mpv.override { scripts = [ mpvScripts.mpris ]; })
    polkit_gnome

    # Other
    ags
    cava
    eog
    file-roller
    grim
    gtk-engine-murrine
    inxi
    home-manager
  ];

  programs = {
    chromium.enable = true;
    zsh.enable = true;
    waybar.enable = true;
    git.enable = true;
    nm-applet.indicator = true;
    thunar.enable = true;
    thunar.plugins = with pkgs.xfce; [
      exo
      mousepad
      thunar-archive-plugin
      thunar-volman
      tumbler
    ];
    virt-manager.enable = true;
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
    greetd = {
      enable = true;
      vt = 3;
      settings = {
        default_session = {
          user = "${vars.username}";
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --remember --asterisks --time --cmd Hyprland";
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
