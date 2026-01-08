# NixOS Module
{ globals, ... }:
{
  # NixOS modules
  imports = [
    ./dms-greeter.nix
    ../../niri
  ];

  # Home manager modules
  home-manager.users.${globals.username}.imports = [
    ./dms.nix
  ];
}
