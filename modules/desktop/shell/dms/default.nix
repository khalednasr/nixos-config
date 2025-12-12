# Home Manager Module
{
  pkgs,
  lib,
  inputs,
  globals,
  ...
}:
{
  imports = [
    inputs.dankMaterialShell.homeModules.dankMaterialShell.default
  ];

  programs.dankMaterialShell = {
    enable = true;

    systemd.enable = false;
    enableSystemMonitoring = true;
    enableVPN = true;
    enableDynamicTheming = true;
    enableAudioWavelength = true;
    enableCalendarEvents = false;
  };

  home.file.".config/gtk-3.0/gtk.css".text = ''@import url("dank-colors.css");'';
  home.file.".config/gtk-4.0/gtk.css".text = ''@import url("dank-colors.css");'';
  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3";
      package = pkgs.adw-gtk3;
    };
  };

  home.packages = [
    pkgs.papirus-icon-theme
  ];

  qt = {
    enable = true;
    platformTheme.name = "qtct";

    qt5ctSettings = {
      Appearance = {
        color_scheme_path = "${globals.homeDir}/.config/qt6ct/colors/matugen.conf";
        custom_palette = true;
        icon_theme = "Papirus-Dark";
      };
    };

    qt6ctSettings = {
      Appearance = {
        color_scheme_path = "${globals.homeDir}/.config/qt6ct/colors/matugen.conf";
        custom_palette = true;
        icon_theme = "Papirus-Dark";
      };
    };
  };

  home.file."./.config/DankMaterialShell/settings.json".source = ./settings.json;
  home.file."./.config/niri/shell_config.kdl".source = ./niri_shell_config.kdl;

  # In case dms has never been run and its auto-generated kdl files do not exist
  # in niri configuration, place dummy files there to prevent niri from failing
  # to load configuration
  home.activation = {
    niri_dms_integration = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      mkdir -p ${globals.homeDir}/.config/niri/dms 
      touch ${globals.homeDir}/.config/niri/dms/colors.kdl
      touch ${globals.homeDir}/.config/niri/dms/wpblur.kdl
      touch ${globals.homeDir}/.config/niri/dms/alttab.kdl
    '';
  };
}
