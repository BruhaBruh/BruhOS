{ pkgs, ... }:

{
  home.packages = with pkgs; [
    go
    nodejs_22
    nodePackages_latest.pnpm
    rustup
  ];
}
