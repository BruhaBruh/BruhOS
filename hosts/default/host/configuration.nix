{ config, pkgs, vars, options, lib, inputs, system, ...}:

{
  imports = [
    ./hardware-configuration.nix
    ../../../modules/amd-drivers.nix
    ../../../modules/nvidia-drivers.nix
    ../../../modules/nvidia-prime-drivers.nix
    ../../../modules/intel-drivers.nix
    ./modules
  ];

  nixpkgs.config.allowUnfree = true;

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "schedutil";
  };

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  console.keyMap = "us";

  system.stateVersion = "24.05";
}