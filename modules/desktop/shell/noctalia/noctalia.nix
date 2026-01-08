# Home Manager Module
{
  pkgs,
  lib,
  inputs,
  globals,
  locals,
  ...
}:
{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia-shell = {
    enable = true;
    settings = {
      settingsVersion = 26;
      bar = {
        backgroundOpacity = 0;
        density = "comfortable";
        widgets = {
          left = [
            {
              id = "TaskbarGrouped";
              hideUnoccupied = true;
              labelMode = "none";
            }
            {
              id = "Spacer";
              width = 40;
            }
            {
              id = "MediaMini";
              hideMode = "hidden";
              showVisualizer = true;
            }
          ];
          center = [
            {
              id = "Clock";
              usePrimaryColor = false;
            }
          ];
          right = [
            { id = "Tray"; }
            { id = "NotificationHistory"; }
          ]
          ++ (if locals.laptop then [ { id = "Battery"; } ] else [ ])
          ++ [
            {
              id = "Volume";
            }
            {
              id = "Brightness";
            }
            {
              id = "ControlCenter";
            }
          ];
        };
      };
      ui = {
        fontDefault = "Ubuntu";
        fontFixed = "Ubuntu Sans Mono";
        panelBackgroundOpacity = 0.5;
      };
      location = {
        name = "${globals.timeZone}";
      };
      appLauncher = {
        terminalCommand = "kitty -e";
      };
      dock = {
        enabled = false;
      };
      brightness = {
        brightnessStep = 5;
        enforceMinimum = true;
        enableDdcSupport = true;
      };
      colorSchemes = {
        darkMode = true;
        useWallpaperColors = true;
        matugenSchemeType = "scheme-tonal-spot";
      };
      templates = {
        gtk = true;
        qt = true;
        ${globals.terminal} = true;
        niri = true;
      };
    };
  };

  home.packages = [
    pkgs.papirus-icon-theme
  ];

  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3";
      package = pkgs.adw-gtk3;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "qtct";

    qt5ctSettings = {
      Appearance = {
        color_scheme_path = "${globals.homeDir}/.config/qt6ct/colors/noctalia.conf";
        custom_palette = true;
        icon_theme = "Papirus-Dark";
      };
    };

    qt6ctSettings = {
      Appearance = {
        color_scheme_path = "${globals.homeDir}/.config/qt6ct/colors/noctalia.conf";
        custom_palette = true;
        icon_theme = "Papirus-Dark";
      };
    };
  };

  home.file."./.config/niri/shell-config.kdl".source = ./niri-shell-config.kdl;

  # In case noctalia-shell has never been run and noctalia.kdl does not exist
  # in niri configuration, place a dummy file there to prevent niri from failing
  # to load configuration
  home.activation = {
    niri_noctalia_integration = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      touch ${globals.homeDir}/.config/niri/noctalia.kdl
    '';
  };
}
