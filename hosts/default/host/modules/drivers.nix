{ ... }:

{
  drivers.amdgpu.enable = false;
  drivers.intel.enable = false;
  drivers.nvidia.enable = true;
  drivers.nvidia-prime = {
    enable = false;
    intelBusID = "";
    nvidiaBusID = "";
  };
}