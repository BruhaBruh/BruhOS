{ config, ... }:

{
  boot = {
    kernelModules = [ "v4l2loopback" ];
    kernelParams = [ "usbcore.autosuspend=-1" ];
    extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
    supportedFilesystems = [ "ntfs" ];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };
}
