# Home Manager Module
{ globals, ... }:
{
  programs.yazi = {
    enable = true;
    enableZshIntegration = (globals.shell == "zsh");
    enableFishIntegration = (globals.shell == "fish");

    shellWrapperName = "y";
    settings = {
      mgr.ratio = [0 3 3];
    };
  };
}
