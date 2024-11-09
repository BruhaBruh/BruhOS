{ lib, system, pkgs, pkgs-stable, vars, ... }@inputs:

with lib; let
  loadScript = script: (import script {
    inherit lib system pkgs pkgs-stable vars inputs;
  });
in
{
  openproject = loadScript ./openproject.nix;
  randomwallpaper = loadScript ./randomwallpaper.nix;
  powermenu = loadScript ./powermenu.nix;
  journallog = loadScript ./journallog.nix;
}
