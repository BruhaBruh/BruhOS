{ pkgs, inputs, ... }: {
  nixpkgs.config = {
    allowUnfree = true;
  };

  environment.systemPackages = with pkgs; [
    # System Pacakages
    baobab
    btrfs-progs
    clang
    curl
    cpufrequtils
    duf
    eza
    ffmpeg
    glib
    gsettings-qt
    git
    killall
    libappindicator
    libnotify
    openssl
    pciutils
    vim
    wget
    xdg-user-dirs
    xdg-utils
    fastfetch
    (mpv.override { scripts = [ mpvScripts.mpris ]; })

    # Hyprland
    ags
    btop
    cava
    eog
    gnome-system-monitor
    file-roller
    grim
    gtk-engine-murrine
    hyprcursor
    hypridle
    imagemagick
    inxi
    jq
    libsForQt5.qtstyleplugin-kvantum
    networkmanagerapplet
    nwg-look
    nvtopPackages.full
    pamixer
    pavucontrol
    playerctl
    polkit_gnome
    pyprland
    qt5ct
    qt6ct
    qt6.qtwayland
    qt6Packages.qtstyleplugin-kvantum
    rofi-wayland
    slurp
    swappy
    swaynotificationcenter
    swww
    unzip
    wallust
    wl-clipboard
    wlogout
    yad
    yt-dlp

    vscode

    # OLD
    fzf
    home-manager
  ];

  fonts.packages = with pkgs; [
    noto-fonts
    fira-code
    noto-fonts-cjk
    jetbrains-mono
    font-awesome
    terminus_font
    (nerdfonts.override { fonts = ["JetBrainsMono"]; })
  ];

  programs = {
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      xwayland.enable = true;
    };

    waybar.enable = true;
    hyprlock.enable = true;
    firefox.enable = true;
    git.enable = true;
    nm-applet.indicator = true;

    foot = {
      enable = true;
      settings.main.font = "JetBrainsMonoNerdFont-Medium:size=12";
    };

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
}
