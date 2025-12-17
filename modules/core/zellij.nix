# Home Manager Module
{ globals, ... }:
{
  programs = {
    zellij = {
      enable = true;
      enableZshIntegration = (globals.shell == "zsh");
      enableFishIntegration = (globals.shell == "fish");
      exitShellOnExit = true;

      settings = {
        show_startup_tips = false;
        default_layout = "disable-status-bar";
      };

      extraConfig = ''
        keybinds clear-defaults=true {
          normal {
            bind "Alt t" { NewPane; }
            bind "Alt Shift t" { NewTab; }
            bind "Alt q" { CloseFocus; }
            bind "Alt Shift q" { CloseTab; }

            bind "Alt s" { LaunchOrFocusPlugin "zellij:session-manager" { floating true; }; }
            bind "Alt d" { Detach; }

            bind "Alt k" { MoveFocus "Up"; }
            bind "Alt j" { MoveFocus "Down"; }
            bind "Alt h" { MoveFocus "Left"; }
            bind "Alt l" { MoveFocus "Right"; }
            bind "Alt Shift h" { GoToPreviousTab; }
            bind "Alt Shift l" { GoToNextTab; }

            bind "Alt 1" { GoToTab 1; }
            bind "Alt 2" { GoToTab 2; }
            bind "Alt 3" { GoToTab 3; }
            bind "Alt 4" { GoToTab 4; }
            bind "Alt 5" { GoToTab 5; }
            bind "Alt 6" { GoToTab 6; }
            bind "Alt 7" { GoToTab 7; }
            bind "Alt 8" { GoToTab 8; }
            bind "Alt 9" { GoToTab 9; }

            bind "Alt Up" { Resize "Up"; }
            bind "Alt Down" { Resize "Down"; }
            bind "Alt Down" { Resize "Down"; }
            bind "Alt Left" { Resize "Left"; }
            bind "Alt Right" { Resize "Right"; }
            
            bind "Alt f" { ToggleFloatingPanes; }
            bind "Alt Shift f" { ToggleFocusFullscreen; }
          }
        }
      '';
    };
  };
}
