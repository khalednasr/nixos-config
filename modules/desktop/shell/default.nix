# NixOS Module
{ globals, ... }:
{
  # NixOS modules
  imports = [
    ./${globals.desktopShell}
  ];
}
