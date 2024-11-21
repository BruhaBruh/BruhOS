{ pkgs, ... }:

{

  home.file.".config/rofi" = {
    source = ../../config/rofi;
    recursive = true;
  };

  programs.rofi = {
    enable = true;
    plugins = with pkgs; [
      rofi-calc
      rofi-emoji
    ];
    extraConfig = {
      show-icons = true;

      terminal = "foot";

      drun-display-format = "{icon} {name}";
    };
  };
}
