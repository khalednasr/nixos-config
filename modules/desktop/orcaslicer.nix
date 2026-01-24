# NixOS Module
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    orca-slicer
  ];

  networking.firewall.allowedUDPPorts = [ 1900 2021 ];
}
