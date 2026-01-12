{ config, nixos-raspberrypi, ... }:
{
  imports = with nixos-raspberrypi.nixosModules; [
    raspberry-pi-5.base
    raspberry-pi-5.page-size-16k
    raspberry-pi-5.display-vc4
  ];

  fileSystems = {
    "/boot/firmware" = {
      device = "/dev/disk/by-uuid/89E3-C3CC";
      fsType = "vfat";
      options = [
        "noatime"
        "noauto"
        "x-systemd.automount"
        "x-systemd.idle-timeout=1min"
      ];
    };

    "/" = {
      device = "/dev/disk/by-uuid/d68a27e2-b2a1-4669-9dd5-5d235c7be63e";
      fsType = "ext4";
      options = [ "noatime" ];
    };

    "/home" = {
      device = "/dev/disk/by-uuid/92819844-ed02-406e-b534-333f463c1a72";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };

  system.nixos.tags =
    let
      cfg = config.boot.loader.raspberryPi;
    in
    [
      "raspberry-pi-${cfg.variant}"
      cfg.bootloader
      config.boot.kernelPackages.kernel.version
    ];
}
