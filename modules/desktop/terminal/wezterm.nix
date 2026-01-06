# Home Manager Module
{ ... }:
{
  programs.wezterm.enable = true;
  home.file.".config/wezterm/wezterm.lua".source = ./wezterm.lua;
}
