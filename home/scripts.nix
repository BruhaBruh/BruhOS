{ scripts, ... }:

{
  home.packages = with scripts; [
    openproject
    randomwallpaper
  ];
}