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
        default_layout = "compact";
      };

      extraConfig = ''
        keybinds clear-defaults=true {
          normal {
            bind "Alt n" { NewPane; }
            bind "Alt Shift n" { NewTab; }
            bind "Alt x" { CloseFocus; }
            bind "Alt Shift x" { CloseTab; }

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
  # home.file.".config/zellij/layouts/default.kdl".text = ''
  #   layout {
  #     swap_tiled_layout name="Default" {
  #       tab max_panes=2 {
  #         pane
  #         pane
  #       }
  #       tab {
  #         pane split_direction="vertical" {
  #           pane
  #           pane split_direction="horizontal" {
  #             pane
  #             pane
  #             pane
  #           }
  #         }
  #       }
  #     }
  #   }
  # '';
}
