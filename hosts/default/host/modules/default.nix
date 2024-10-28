{ ... }:

{
  imports = [
    ./user.nix
    ./boot.nix
    ./drivers.nix
    ./networking.nix
    ./time.nix
    ./i18n.nix
    ./programs.nix
    ./packages.nix
    ./font.nix
    ./xdg-portal.nix
    ./services.nix
    ./hardware.nix
    ./security.nix
    ./virtualisation.nix
    ./env.nix
  ];
}