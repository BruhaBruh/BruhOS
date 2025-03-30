{ config, ... }: {
  # Specific for my pc. You can comment boot.blacklistedKernelModules
  # boot.blacklistedKernelModules = [
  #   "i2c_nvidia_gpu"
  #   "ucsi_ccg"
  # ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
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
