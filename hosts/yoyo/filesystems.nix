# NixOS Module
{ ... }:
{
  boot.supportedFilesystems = [ "ntfs" ];

  fileSystems."/run/media/windows" = {
    device = "/dev/disk/by-uuid/9868A51468A4F1E4"; # get UUID using lsblk -f
    options = ["nofail"];
    fsType = "ntfs3";
  };
}
