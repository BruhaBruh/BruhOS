{ config, pkgs, ... }: {
  imports = [
  ]; 

  home = {
    username = "bruhabruh";
    homeDirectory = "/home/bruhabruh";
    stateVersion = "24.05";
  };

  programs.zsh.shellAliases = let 
    flakeDirectory = "$HOME/.dotfiles";
  in {
    rb = "sudo nixos-rebuild switch --flake ${flakeDirectory}";
    upd = "nix flake update ${flakeDirectory}";
    upg = "sudo nixos-rebuild switch --upgrade --flake ${flakeDirectory}";
    hms = "home-manager switch --flake ${flakeDirectory}";

    conf = "$EDITOR ${flakeDirectory}/nixos/configuration.nix";
    pkgs = "$EDITOR ${flakeDirectory}/nixos/packages.nix";
  };
}

