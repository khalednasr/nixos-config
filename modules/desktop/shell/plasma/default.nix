# NixOS Module
{ globals, ... }:
{
  # Enable SDDM and Plasma6
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Home manager modules
  home-manager.users.${globals.username}.imports = [
    ./plasma.nix
  ];
}
