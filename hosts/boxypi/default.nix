{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./host-packages.nix

    ../../modules/core
  ];
}
