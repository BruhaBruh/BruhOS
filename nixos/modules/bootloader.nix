{ config, ... }: {
  boot = {
    kernelModules = [ "v4l2loopback" ];
    extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];

    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    supportedFilesystems = [ "ntfs" ];

    # initrd = {
    #   availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sb_mod" ];
    #   kernelModules = [ ];
    # };

    tmp = {
      useTmpfs = false;
      tmpfsSize = "30%";
    };
  };
}

