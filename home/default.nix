{ vars, ... }:

{
  imports = [
    ./shell.nix
    ./stylix.nix
    ./development.nix
    ./programs
    ./scripts
  ];

  nixpkgs.config.allowUnfree = true;

  home.username = "${vars.username}";
  home.homeDirectory = "/home/${vars.username}";
  home.stateVersion = "24.05";
}
