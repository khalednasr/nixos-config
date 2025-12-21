# NixOS Module
{ ... }:
{
  boot.supportedFilesystems = [ "ntfs" ];

  fileSystems."/run/media/data" = {
    device = "/dev/disk/by-uuid/2C0A43280A42EF00"; # get UUID using lsblk -f
    options = ["nofail"];
    fsType = "ntfs3";
  };
}
