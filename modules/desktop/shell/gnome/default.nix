# NixOS Module
{ pkgs, globals, ... }:
{
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  environment.systemPackages = with pkgs; [
    dconf2nix
    gnomeExtensions.paperwm
    gnomeExtensions.disable-3-finger-gestures-redux
    gnomeExtensions.appindicator
  ];

  environment.gnome.excludePackages = with pkgs; [ 
    gnome-tour
    gnome-user-docs 
    epiphany
  ];

  home-manager.users.${globals.username} = {
    imports = [
      ./dconf.nix
      ./theme.nix
    ];
  };
}
