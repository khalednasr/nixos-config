# NixOS Module
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ripgrep
    btop
    ncdu
    wget
    curl
    gnutar
    zip
    unzip
    rar
  ];
}
