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
    inputs.plasma-manager.homeModules.plasma-manager
  ];

  home.packages = with pkgs; [
    (catppuccin-kde.override {
      flavour = [ "macchiato" ];
      accents = [ "lavender" ];
    })
    kdePackages.kcalc
    kdePackages.krohnkite
    kdotool
    libnotify
  ];

  programs.plasma = {
    enable = true;
    overrideConfig = true;

    input = {
      keyboard = {
        layouts = [ { layout = "de"; } { layout = "eg"; } ];
        repeatDelay = 300;
        repeatRate = 30;
      };
    };

    kwin = {
      virtualDesktops = {
        number = 5;
        rows = 1;
      };
    };

    workspace = {
      enableMiddleClickPaste = false;
      clickItemTo = "select";
      colorScheme = "CatppuccinMacchiatoLavender";
      cursor.theme = "Yaru";
      splashScreen.engine = "none";
      splashScreen.theme = "none";
      tooltipDelay = 1;
    };

    powerdevil = {
      AC = {
        autoSuspend.action = "nothing";
        dimDisplay.enable = false;
        powerButtonAction = "shutDown";
        turnOffDisplay.idleTimeout = "never";
      };
      battery = {
        autoSuspend.action = "nothing";
        dimDisplay.enable = false;
        powerButtonAction = "shutDown";
        turnOffDisplay.idleTimeout = "never";
      };
    };

    # panels = [
    #   {
    #     # Top Left
    #     alignment = "left";
    #     height = 30;
    #     lengthMode = "fit";
    #     location = "top";
    #     opacity = "translucent";
    #     widgets = [
    #       # Desktop/workspace pager
    #       {
    #         name = "org.dhruv8sh.kara";
    #         config = {
    #           general = {
    #             animationDuration = 0;
    #             highlightType = 1;
    #             spacing = 3;
    #             type = 1;
    #           };
    #           type1 = {
    #             fixedLen = 3;
    #             labelSource = 0;
    #           };
    #         };
    #       }
    #     ];
    #   }
    #
    #   # Top Center
    #   {
    #     alignment = "center";
    #     height = 30;
    #     lengthMode = "fit";
    #     location = "top";
    #     opacity = "translucent";
    #     widgets = [
    #       # Clock
    #       {
    #         name = "org.kde.plasma.digitalclock";
    #         config = {
    #           Appearance = {
    #             autoFontAndSize = false;
    #             customDateFormat = "ddd MMM d";
    #             dateDisplayFormat = "BesideTime";
    #             dateFormat = "custom";
    #             fontSize = 11;
    #             fontStyleName = "Regular";
    #             fontWeight = 400;
    #             use24hFormat = 2;
    #           };
    #         };
    #       }
    #     ];
    #   }
    #
    #   # Top Right
    #   {
    #     alignment = "right";
    #     height = 30;
    #     lengthMode = "fit";
    #     location = "top";
    #     opacity = "translucent";
    #     widgets = [
    #       # System tray
    #       {
    #         systemTray = {
    #           icons.scaleToFit = true;
    #           items = {
    #             showAll = false;
    #             shown = [
    #               "org.kde.plasma.battery"
    #               "org.kde.plasma.networkmanagement"
    #               "org.kde.plasma.volume"
    #               "org.kde.plasma.brightness"
    #               "org.kde.plasma.keyboardlayout"
    #             ];
    #
    #             hidden = [
    #               "org.kde.plasma.mediacontroller"
    #               "org.kde.plasma.clipboard"
    #               "org.kde.plasma.devicenotifier"
    #               "xdg-desktop-portal-kde"
    #               "NordVPN"
    #               "sunshine"
    #             ];
    #           };
    #         };
    #       }
    #     ];
    #   }
    # ]; # panels

    window-rules = [
      {
        apply = {
          desktops = "Desktop_1";
          desktopsrule = "3";
        };
        description = "Assign Browser to Desktop 1";
        match = {
          window-class = {
            value = "${globals.browser}";
            type = "substring";
          };
          window-types = [ "normal" ];
        };
      }
      {
        apply = {
          desktops = "Desktop_2";
          desktopsrule = "3";
        };
        description = "Assign Terminal to Desktop 2";
        match = {
          window-class = {
            value = "${globals.terminal}";
            type = "substring";
          };
          window-types = [ "normal" ];
        };
      }
    ];

    hotkeys.commands = {
      # Launching
      launch-krunner = {
        name = "Launch KRunner";
        key = "Meta+D";
        command = "krunner";
      };
      launch-terminal = {
        name = "Launch Terminal";
        key = "Meta+T";
        command = "${globals.terminal}";
      };
      launch-browser = {
        name = "Launch Browser";
        key = "Meta+B";
        command = "${globals.browser}";
      };
      launch-explorer = {
        name = "Launch Explorer";
        key = "Meta+E";
        command = "dolphin";
      };

      # Screenshots
      screenshot-region = {
        name = "Capture a rectangular region of the screen";
        key = "Meta+Shift+S";
        command = "spectacle --region --nonotify";
      };
      screenshot-screen = {
        name = "Capture the entire desktop";
        key = "Meta+Ctrl+S";
        command = "spectacle --fullscreen --nonotify";
      };
    };

    shortcuts = {
      ksmserver = {
        "Lock Session" = [
          "Screensaver"
          "Meta+Shift+L"
        ];
        "LogOut" = [
          "Meta+Shift+Q"
        ];
      };

      "KDE Keyboard Layout Switcher" = {
        "Switch to Next Keyboard Layout" = "Meta+Space";
      };

      kwin = {
        "KrohnkiteMonocleLayout" = [ ];
        "Switch to Desktop 1" = "Meta+1";
        "Switch to Desktop 2" = "Meta+2";
        "Switch to Desktop 3" = "Meta+3";
        "Switch to Desktop 4" = "Meta+4";
        "Switch to Desktop 5" = "Meta+5";
        "Window to Desktop 1" = "Meta+Ctrl+1";
        "Window to Desktop 2" = "Meta+Ctrl+2";
        "Window to Desktop 3" = "Meta+Ctrl+3";
        "Window to Desktop 4" = "Meta+Ctrl+4";
        "Window to Desktop 5" = "Meta+Ctrl+5";
        "Window to Next Desktop" = "Meta+Ctrl+L";
        "Window to Previous Desktop" = "Meta+Ctrl+H";
        "Window Close" = "Meta+Q";
        "Window Maximize" = "Meta+F";
        "Window Fullscreen" = "Meta+Shift+F";
        "Window Move Center" = "Meta+C";
        "Toggle Overview" = "Meta+W";
      };
    };
  };
}
