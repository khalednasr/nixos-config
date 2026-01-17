# NixOS Module
{  ... }:
{
  # first physical offset obtained with:
  # sudo filefrag -v /var/lib/swapfile | head
  boot.kernelParams = ["resume_offset=70547456"];

  # root parition uuid. lsblk -f
  boot.resumeDevice = "/dev/disk/by-uuid/a74a1e81-8b9b-4dba-b49c-a6e17151dad5";

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 32 * 1024; # 32GB
    }
  ];
}
