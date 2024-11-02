{ config, ... }:

{
  imports = [
    ./openproject.nix
  ];

  scripts.openproject.enable = true;
}
