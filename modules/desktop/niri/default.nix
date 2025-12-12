# NixOS Module
{ pkgs, globals, locals, ... }:
{
  programs.niri.enable = true;

  environment.variables = {
    XDG_CURRENT_DESKTOP = "niri";
    QT_QPA_PLATFORM = "wayland;xcb";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    NIXOS_OZONE_WL = "1";
  };

  environment.systemPackages = with pkgs; [
    wl-clipboard
    wayland-utils
    xwayland-satellite
    bibata-cursors
  ];

  home-manager.users.${globals.username} = {
    home.file.".config/niri/config.kdl".source = ./niri.kdl;
    home.file.".config/niri/displays.kdl".text = locals.niriDisplayConfig;
  };
}
