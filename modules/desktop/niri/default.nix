# NixOS Module
{ pkgs, globals, ... }:
{
  programs.niri.enable = true;

  environment.variables = {
    XDG_CURRENT_DESKTOP = "niri";
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_QPA_PLATFORMTHEME = "qt6ct";
    QT_QPA_PLATFORMTHEME_QT6 = "qt6ct";
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
  };
}
