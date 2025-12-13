# Home Manager Module
{ globals, ... }:
{
  imports = [
    ./${globals.terminal}.nix
  ];
}
