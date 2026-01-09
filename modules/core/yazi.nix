# Home Manager Module
{ pkgs, globals, ... }:
{
  programs.yazi = {
    enable = true;
    enableZshIntegration = (globals.shell == "zsh");
    enableFishIntegration = (globals.shell == "fish");
    shellWrapperName = "y";

    extraPackages = with pkgs; [
      fzf
      ripgrep
      fd
      ffmpeg
      zoxide
      resvg
      # _7zz-rar
      _7zz
      jq
      poppler
      trash-cli
    ];

    settings = {
      mgr.ratio = [0 3 3];
    };
    
    plugins = with pkgs.yaziPlugins; { 
      inherit
        recycle-bin
        mount
        restore
        compress;

      what-size = pkgs.fetchFromGitHub {
        owner = "pirafrank";
        repo = "what-size.yazi";
        rev = "179ebf69c9c3ade40cacc0f25e9557a43427c6ca";
        hash = "sha256-7q/45TopqbojNRvYDmP9+hgSGPmiyLHBcV051qpOB2Y=";
      };
    };

    keymap = {
      input.prepend_keymap = [
        { run = "close"; on = [ "<ESC>" ]; }
      ];

      mgr.prepend_keymap = [
        { run = "plugin restore"; on = "u";  desc = "Restore last deleted files/folders"; }

        { run = "plugin what-size"; on = ["g" "s"]; desc = "What size?"; }
        { run = "plugin mount"; on = ["g" "m"]; desc = "Disks"; }
        { run = "plugin recycle-bin"; on = ["g" "b"]; desc = "Recycle Bin"; }

        { run = "plugin compress";     on = ["C" "a"]; desc = "Archive"; }
        { run = "plugin compress -p";  on = ["C" "p"]; desc = "Archive (password)"; }
        { run = "plugin compress -ph"; on = ["C" "h"]; desc = "Archive (password+header)"; }
        { run = "plugin compress -l";  on = ["C" "l"]; desc = "Archive (compression level)"; }
        { run = "plugin compress -phl";on = ["C" "u"]; desc = "Archive (password+header+level)"; }
      ];
    };
  };
}
