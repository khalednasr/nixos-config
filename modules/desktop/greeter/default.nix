# NixOS Module
{ globals, ... }:
{
  imports = [
    ./${globals.desktopGreeter}.nix
  ];
}
