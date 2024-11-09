{ config, pkgs, ... }: {
  # Specific for my pc. You can comment boot.blacklistedKernelModules
  boot.blacklistedKernelModules = [
    "i2c_nvidia_gpu"
    "ucsi_ccg"
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    # extraPackages = with pkgs; [
    #   vaapiVdpau
    #   libvdpau
    #   libvdpau-va-gl
    #   nvidia-vaapi-driver
    #   vdpauinfo
    #   libva
    #   libva-utils
    # ];
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    open = false;
    nvidiaSettings = true;
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
