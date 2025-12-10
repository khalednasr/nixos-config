{ pkgs, inputs, globals, ... }:
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
            {
              id = "Tray";
            }
            {
              id = "NotificationHistory";
            }
            {
              id = "Battery";
            }
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
        kitty = true;
        pywalfox = true;
        niri = true;
      };
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3";
      package = pkgs.adw-gtk3;
    };
  };
}
