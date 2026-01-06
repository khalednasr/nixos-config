{ globals, ... }:
{
  # NixOS modules
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ./rename-fix.nix
    ./host-packages.nix

    ../../modules/core
  ];

  # Home manager modules
  home-manager.users.${globals.username}.imports = [
    ../../modules/desktop/terminal/wezterm.nix # for cli in remote sessions
  ];

  # Initial credentials
  users.mutableUsers = true;
  users.users.root.initialHashedPassword = "$y$j9T$EBGJZhKc1UEufVIlCnPUx0$oJ9sUx4pYh4UjCxnf2ezrkjvMibRKT4XD7UibTIBJCA";
  users.users."${globals.username}".initialHashedPassword = "$y$j9T$48ADycPVIa7.VrgKUoEap/$AS/EgZiDP0Z3tpJ1n2So.Zc/Feo27uLS/pcgNoFfYd6";
}
