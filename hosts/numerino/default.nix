{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ./filesystems.nix
    ./hibernation.nix
    ./host-packages.nix
    ../../modules/core
    ../../modules/core/gpu/nvidia.nix
    ../../modules/desktop
  ];
}
