# NixOS Module
{ ... }:
{
  boot = {
    loader.raspberryPi.bootloader = "kernel";
    supportedFilesystems = [ "ntfs" ];
  };
}
