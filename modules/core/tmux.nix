# Home Manager Module
{ globals, ... }:
{
  programs = {
    tmux  = {
      enable = true;
      keyMode = "vi";
      mouse = true;
    };
  };
}
