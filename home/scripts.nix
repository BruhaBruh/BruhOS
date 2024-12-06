{ scripts, ... }:

{
  home.packages = with scripts; [
    openproject
    wallpaper
    randomwallpaper
    powermenu
    journallog
    askpass
    sp
    waybarstop
  ];

  home.sessionVariables = {
    SUDO_ASKPASS = "${scripts.askpass}/bin/askpass";
  };
}
