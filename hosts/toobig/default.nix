{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ./filesystems.nix
    ./host-packages.nix
    ./extra-users.nix
    ../../modules/core
    ../../modules/core/gpu/nvidia.nix
    ../../modules/desktop
  ];
}
