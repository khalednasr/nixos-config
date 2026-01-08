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
    home.file.".config/niri/app-bindings.kdl".text = ''
      binds {
        Mod+T hotkey-overlay-title="Open a Terminal" { spawn "${globals.terminal}"; }
        Mod+B hotkey-overlay-title="Open a Browser" { spawn "${globals.browser}"; }
        Mod+E hotkey-overlay-title="Open a File Explorer" { spawn-sh "${globals.terminal} -e ${globals.shell} -c yazi"; }
      }
    '';
  };
}
