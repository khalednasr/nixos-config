{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ./host-packages.nix

    ../../modules/core
  ];
}
