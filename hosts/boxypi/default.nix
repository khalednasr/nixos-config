{ globals, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ./rename-fix.nix
    ./host-packages.nix

    ../../modules/core
  ];

  # Initial credentials
  users.mutableUsers = true;
  users.users.root.initialPassword = "nixos";
  users.users."${globals.username}".initialPassword = "nixos";
}
