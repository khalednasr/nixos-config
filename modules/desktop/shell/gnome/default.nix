# NixOS Module
{ pkgs, globals, ... }:
{
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  environment.systemPackages = with pkgs; [
    dconf2nix
    gnomeExtensions.paperwm
  ];

  home-manager.users.${globals.username}.imports = [
    ./dconf.nix
  ];
}
