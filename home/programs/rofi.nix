{ ... }:

{

  home.file.".config/rofi" = {
    source = ../../config/rofi;
    recursive = true;
  };

  programs.rofi = {
    enable = true;
    extraConfig = {
      icon-theme = "Papirus";
      show-icons = true;

      terminal = "foot";

      drun-display-format = "{icon} {name}";
    };
  };
}
