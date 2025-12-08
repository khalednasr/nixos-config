# NixOS Module
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    brightnessctl
  ];

  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;
}
