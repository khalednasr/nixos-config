# NixOS Module
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ripgrep
    btop
  ];
}
