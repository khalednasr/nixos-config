# NixOS Module
{ globals, ... }:
{
  imports = [
    ./${globals.browser}.nix
  ];
}
