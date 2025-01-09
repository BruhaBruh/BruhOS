{ vars, lib, ... }:

{
  imports = [
    ./shell.nix
    ./stylix.nix
    ./development.nix
    ./scripts.nix
    ./programs
  ];

  nixpkgs.config.allowUnfree = true;

  home.username = "${vars.username}";
  home.homeDirectory = "/home/${vars.username}";
  home.stateVersion = "24.05";

  # COMMENT THIS IF DISK MOUNTING DOES NOT USED
  home.activation.linkWindows = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    [ ! -L /home/${vars.username}/windows ] && ln -sf /mnt/windows /home/${vars.username}/windows
  '';
}
