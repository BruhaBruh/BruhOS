{ lib, system, pkgs, pkgs-stable, vars, ... }@inputs:

with lib; {
  openproject = (import ./openproject.nix {
    inherit lib system pkgs pkgs-stable vars inputs;
  }).script;
  randomwallpaper = (import ./randomwallpaper.nix {
    inherit lib system pkgs pkgs-stable vars inputs;
  }).script;
}
