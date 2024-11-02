{ ... }:

{
  imports = [
    ./nixos.nix
    ./networking.nix
    ./time.nix
    ./i18n.nix
    ./boot.nix
    ./nvidia.nix
    ./xserver.nix
    ./security.nix
    ./sound.nix
    ./env.nix
    ./input.nix
    ./user.nix
    ./xdg.nix
    ./hyprland.nix
    ./trim.nix
    ./bluetooth.nix
    ./packages.nix
    ./font.nix
    ./stylix.nix
  ];
}
