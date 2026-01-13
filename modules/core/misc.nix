# NixOS Module
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ripgrep
    htop
    ncdu
    wget
    curl
    gnutar
    zip
    unzip
    sshfs
  ];
}
