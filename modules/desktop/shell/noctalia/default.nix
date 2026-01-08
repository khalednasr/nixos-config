# NixOS Module
{ globals, ... }:
{
  # NixOS modules
  imports = [
    ./tuigreet.nix
    ../../niri
  ];

  # Home manager modules
  home-manager.users.${globals.username}.imports = [
    ./noctalia.nix
  ];
}
