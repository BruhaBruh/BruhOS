{ inputs, host, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./packages.nix
    ./modules
  ];

  networking.hostName = host;

  time.timeZone = "Asia/Yeakaterinburg";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "24.05";
}
