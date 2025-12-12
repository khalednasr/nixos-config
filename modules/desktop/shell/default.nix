# Home Manager Module
{ globals, ... }:
{
  imports = [
    ./${globals.desktopShell}
  ];
}
