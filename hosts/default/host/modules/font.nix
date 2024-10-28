{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    noto-fonts
    fira-code
    noto-fonts-cjk-sans
    jetbrains-mono
    font-awesome
    terminus_font
    (nerdfonts.override {fonts = ["JetBrainsMono"];})
  ];
}