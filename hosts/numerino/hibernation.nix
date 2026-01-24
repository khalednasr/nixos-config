# NixOS Module
{  ... }:
{
  # first physical offset obtained with:
  # sudo filefrag -v /var/lib/swapfile | head
  boot.kernelParams = ["resume_offset=292511744"];

  # root parition uuid. lsblk -f
  boot.resumeDevice = "/dev/disk/by-uuid/825cb36a-73a7-4297-8de9-d45751e0cb4c";

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 32 * 1024; # 32GB
    }
  ];
}
