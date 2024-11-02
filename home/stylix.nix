{ pkgs, lib, ... }:

{
  stylix = {
    enable = true;
    targets = {
      hyprland.enable = false;
      hyprpaper.enable = false;
      vscode.enable = false;
      rofi.enable = false;
      waybar.enable = false;
    };
  };

  gtk = {
    enable = true;

    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };
  };
}
