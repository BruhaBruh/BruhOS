{ config, lib, pkgs, ... }:

let
  hostName = "nixos";
  username = "bruhabruh";
in {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "${hostName}";
  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
    git
    vim
  ];

  users.users.${username} = {
    isNormalUser = true;
    homeMode = "755";
    extraGroups = [ "wheel" "input" "networkmanager" ];
  };

  system.stateVersion = "24.05";
}
