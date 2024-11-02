{ vars, ... }:

{
  imports = [
    ./shell.nix
    ./stylix.nix
    ./scripts.nix
    ./development.nix
    ./programs
  ];

  nixpkgs.config.allowUnfree = true;

  home.username = "${vars.username}";
  home.homeDirectory = "/home/${vars.username}";
  home.stateVersion = "24.05";
}
