# NixOS Module
{ pkgs, ... }:
{
  boot = {
    # Bootloader.
    loader.grub.enable = true;
    loader.grub.device = "nodev";
    loader.grub.useOSProber = true;
    loader.grub.efiSupport = true;
    loader.grub.fontSize = 42;
    loader.efi.canTouchEfiVariables = true;

    # Kernel
    kernelPackages = pkgs.linuxPackages_zen;

    # Emulated cross-compilation
    binfmt.emulatedSystems = [ "aarch64-linux" ];
  };
}
