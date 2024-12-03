{ lib, system, pkgs, pkgs-stable, vars, aliases, ... }@inputs:

with lib; let
  loadScript = script: (import script {
    inherit lib system pkgs pkgs-stable vars aliases inputs;
  });
in
{
  askpass = loadScript ./askpass.nix;
  openproject = loadScript ./openproject.nix;
  wallpaper = loadScript ./wallpaper.nix;
  randomwallpaper = loadScript ./randomwallpaper.nix;
  powermenu = loadScript ./powermenu.nix;
  journallog = loadScript ./journallog.nix;
  ssudo = loadScript ./ssudo.nix;
  sp = loadScript ./sp.nix;
}
