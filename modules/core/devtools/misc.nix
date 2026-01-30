# Home Manager Module
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ripgrep
    btop
    ncdu
    wget
    curl
    gnutar
    zip
    unzip
    _7zz
    sshfs
    usbutils
  ];
}
