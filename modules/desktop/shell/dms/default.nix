# NixOS Module
{ globals, ... }:
{
  # NixOS modules
  imports = [
    ../../greeters/dmsgreeter.nix
    ../../niri
  ];

  # Home manager modules
  home-manager.users.${globals.username}.imports = [
    ./dms.nix
  ];
}
