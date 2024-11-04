{ pkgs, ... }:

{
  stylix = {
    enable = true;
    autoEnable = true;
    image = ../../config/wallpapers/1.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
    cursor = {
      name = "catppuccin-macchiato-dark-cursors";
      size = 24;
      package = pkgs.catppuccin-cursors.macchiatoDark;
    };
    fonts = {
      serif = {
        package = pkgs.inter;
        name = "Inter";
      };

      sansSerif = {
        package = pkgs.inter;
        name = "Inter";
      };

      monospace = {
        package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
        name = "JetBrainsMono Nerd Font Mono";
      };

      emoji = {
        package = pkgs.twemoji-color-font;
        name = "Twitter Color Emoji";
      };
    };
  };
}
