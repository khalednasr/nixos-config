# NixOS Module
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    zoom-us
    teams-for-linux
    signal-desktop-bin
    discord
  ];
}
