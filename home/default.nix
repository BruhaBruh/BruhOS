{ vars, ... }:

{
  imports = [
    ./git.nix
    ./shell.nix
    ./stylix.nix
    ./scripts.nix
    ./hyprland.nix
    ./hyprpaper.nix
    ./waybar.nix
    ./foot.nix
    ./rofi.nix
    ./vscode.nix
  ];

  nixpkgs.config.allowUnfree = true;

  home.username = "${vars.username}";
  home.homeDirectory = "/home/${vars.username}";
  home.stateVersion = "24.05";
}
