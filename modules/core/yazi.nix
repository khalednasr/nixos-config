# Home Manager Module
{ ... }:
{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    shellWrapperName = "y";
    settings = {
      mgr.ratio = [0 3 3];
    };
  };
}
