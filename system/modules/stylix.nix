{ pkgs, vars, ... }:

let
  cursor =
    if vars.apple.cursors.enabled then {
      name = "WhiteSur-cursors";
      size = 24;
      package = pkgs.whitesur-cursors;
    } else {
      name = "catppuccin-macchiato-dark-cursors";
      size = 24;
      package = pkgs.catppuccin-cursors.macchiatoDark;
    };
in
{
  stylix = {
    enable = true;
    autoEnable = true;
    image = vars.wallpaper.directory.source + "/${vars.wallpaper.default}";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
    cursor = cursor;
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
