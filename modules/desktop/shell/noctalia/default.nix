# NixOS Module
{ globals, ... }:
{
  # NixOS modules
  imports = [
    ../../greeters/tuigreet.nix
    ../../niri
  ];

  # Home manager modules
  home-manager.users.${globals.username}.imports = [
    ./noctalia.nix
  ];
}
