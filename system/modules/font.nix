{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    noto-fonts
    fira-code
    noto-fonts-cjk-sans
    inter
    jetbrains-mono
    font-awesome
    terminus_font
    (nerdfonts.override { fonts = ["JetBrainsMono"]; })
  ];
  
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      sansSerif = [ "Inter" ];
      monospace = [ "JetBrains Mono" ];
    };
  };
}
