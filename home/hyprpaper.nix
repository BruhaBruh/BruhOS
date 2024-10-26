{ vars, ... }:

let
  wallpaper = "/home/${vars.username}/wallpapers/unknown-dark-mojave-desert.jpg";
in {
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = "${wallpaper}";
      wallpaper = ", ${wallpaper}";
    };
  };
}