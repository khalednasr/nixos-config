{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ./hibernation.nix
    ./filesystems.nix
    ./host-packages.nix
    ../../modules/core
    ../../modules/core/gpu/nvidia-amd-hybrid.nix
    ../../modules/desktop
  ];
}
