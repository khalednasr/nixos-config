{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ./rename-fix.nix
    ./host-packages.nix

    ../../modules/core
  ];
}
