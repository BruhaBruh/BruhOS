{ pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
    });
    settings = {
      mainBar = {
        height = 20;
        layer = "top";
        modules-left = [ "clock" ];
        modules-center = [ "clock" ];
        modules-right = [ "clock" ];

        "clock" = {
          format = "{:%H:%M}";
          format-alt = "{:%b %d %Y}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };
      };
    };
  };
}