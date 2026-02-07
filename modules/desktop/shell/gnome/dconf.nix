{ pkgs, lib, globals, ... }:

with lib.hm.gvariant;
{
  dconf.settings = {
    "org/gnome/shell" = {
        enabled-extensions = [
          pkgs.gnomeExtensions.paperwm.extensionUuid
        ];
      };

    "org/gnome/desktop/input-sources" = {
      mru-sources = [ (mkTuple [ "xkb" "de" ]) ];
      sources = [ (mkTuple [ "xkb" "de" ]) (mkTuple [ "xkb" "eg" ]) ];
      xkb-options = [];
    };

    "org/gnome/desktop/wm/keybindings" = {
      cycle-group = [];
      cycle-group-backward = [];
      cycle-panels = [];
      cycle-panels-backward = [];
      cycle-windows = [];
      cycle-windows-backward = [];
      maximize = [];
      move-to-monitor-down = [];
      move-to-monitor-left = [];
      move-to-monitor-right = [];
      move-to-monitor-up = [];
      move-to-workspace-down = [];
      move-to-workspace-last = [];
      move-to-workspace-left = ["<Super><Control>p"];
      move-to-workspace-right = ["<Super><Control>n"];
      move-to-workspace-up = [];
      panel-run-dialog = [];
      switch-applications = [];
      switch-applications-backward = [];
      switch-group = [];
      switch-group-backward = [];
      switch-input-source = [];
      switch-input-source-backward = [];
      switch-panels = [];
      switch-panels-backward = [];
      switch-to-workspace-1 = ["<Super>1"];
      switch-to-workspace-2 = ["<Super>2"];
      switch-to-workspace-3 = ["<Super>3"];
      switch-to-workspace-4 = ["<Super>4"];
      move-to-workspace-1 = ["<Super><Control>1"];
      move-to-workspace-2 = ["<Super><Control>2"];
      move-to-workspace-3 = ["<Super><Control>3"];
      move-to-workspace-4 = ["<Super><Control>4"];
      switch-to-workspace-last = [];
      switch-to-workspace-left = ["<Super>p"];
      switch-to-workspace-right = ["<Super>n"];
      unmaximize = [];
    };

    "org/gnome/mutter" = {
      attach-modal-dialogs = false;
      edge-tiling = false;
      overlay-key = "";
      workspaces-only-on-primary = false;
      dynamic-workspaces = false;
    };

    "org/gnome/mutter/wayland/keybindings" = {
      restore-shortcuts = [];
    };

    "org/gnome/mutter/keybindings" = {
      cancel-input-capture = [];
      toggle-tiled-left = [];
      toggle-tiled-right = [];
    };

    "org/gnome/desktop/wm/preferences" = {
      num-workspaces = 4;
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [ 
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
      ];
      help = [];
      logout = [];
      magnifier = [];
      magnifier-zoom-in = [];
      magnifier-zoom-out = [];
      on-screen-keyboard = [];
      rotate-video-lock-static = [];
      screenreader = [];
      screensaver = [];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>b";
      command = "${globals.browser}";
      name = "Browser";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Super>t";
      command = "${globals.terminal}";
      name = "Terminal";
    };

    "org/gnome/shell/keybindings" = {
      focus-active-notification = [];
      screenshot = [];
      screenshot-window = [];
      shift-overview-down = [];
      shift-overview-up = [];
      show-screen-recording-ui = [];
      show-screenshot-ui = [];
      switch-to-application-1 = [];
      switch-to-application-2 = [];
      switch-to-application-3 = [];
      switch-to-application-4 = [];
      toggle-application-view = [];
      toggle-message-tray = [];
      toggle-quick-settings = [];
      toggle-overview = ["<Super>d"];
    };

    "org/gnome/shell/extensions/paperwm" = {
      default-focus-mode = 1;
      show-window-position-bar = false;
      show-workspace-indicator = false;
      gesture-workspace-fingers = 0;
      gesture-enabled = false;
      minimap-scale = 0.0;
    };

    "org/gnome/shell/extensions/paperwm/keybindings" = {
      barf-out = [ "<Super><Shift>comma" ];
      barf-out-active = [ "" ];
      close-window = [ "<Super>q" ];
      cycle-height-backwards = [ "" ];
      cycle-width-backwards = [ "" ];
      drift-left = [ "" ];
      drift-right = [ "" ];
      live-alt-tab = [ "" ];
      live-alt-tab-backward = [ "" ];
      live-alt-tab-scratch = [ "" ];
      live-alt-tab-scratch-backward = [ "" ];
      move-down = [ "<Control><Super>j" ];
      move-down-workspace = [ "" ];
      move-left = [ "<Control><Super>h" ];
      move-monitor-above = [ "" ];
      move-monitor-below = [ "" ];
      move-monitor-left = [ "" ];
      move-monitor-right = [ "" ];
      move-previous-workspace = [ "" ];
      move-previous-workspace-backward = [ "" ];
      move-right = [ "<Control><Super>l" ];
      move-space-monitor-above = [ "" ];
      move-space-monitor-below = [ "" ];
      move-space-monitor-left = [ "" ];
      move-space-monitor-right = [ "" ];
      move-up = [ "<Control><Super>k" ];
      move-up-workspace = [ "" ];
      new-window = [ "" ];
      previous-workspace = [ "" ];
      previous-workspace-backward = [ "" ];
      slurp-in = [ "<Super>comma" ];
      swap-monitor-above = [ "" ];
      swap-monitor-below = [ "" ];
      swap-monitor-left = [ "" ];
      swap-monitor-right = [ "" ];
      switch-down = [ "<Super>j" ];
      switch-down-workspace = [ "<Shift><Super>j" ];
      switch-first = [ "" ];
      switch-focus-mode = [ "" ];
      switch-last = [ "" ];
      switch-left = [ "<Super>h" ];
      switch-monitor-above = [ "" ];
      switch-monitor-below = [ "" ];
      switch-monitor-left = [ "" ];
      switch-monitor-right = [ "" ];
      switch-next = [ "" ];
      switch-open-window-position = [ "" ];
      switch-previous = [ "" ];
      switch-right = [ "<Super>l" ];
      switch-up = [ "<Super>k" ];
      switch-up-workspace = [ "<Shift><Super>k" ];
      take-window = [ "" ];
      toggle-scratch = [ "" ];
      toggle-scratch-layer = [ "" ];
      toggle-scratch-window = [ "" ];
      toggle-top-and-position-bar = [ "" ];
    };

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
}
