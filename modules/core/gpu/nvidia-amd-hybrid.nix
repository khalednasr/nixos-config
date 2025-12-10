{ config, locals, ... }:
{
  services.xserver.videoDrivers = [ "modesetting" "amdgpu" "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;

    # Helpful on laptops to power down the dGPU when idle
    powerManagement.enable = true;
    powerManagement.finegrained = true;

    # AMD primary, NVIDIA offload
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };

      amdgpuBusId = locals.amdgpuID;
      nvidiaBusId = locals.nvidiaID;
    };
  };

  hardware.nvidia-container-toolkit.enable = true;
}
