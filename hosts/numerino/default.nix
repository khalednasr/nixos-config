{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./filesystems.nix
    ./host-packages.nix
    ../../modules/core
    ../../modules/core/gpu/nvidia.nix
    ../../modules/desktop
  ];
}
