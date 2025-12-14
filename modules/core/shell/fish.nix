# Home Manager Module
{ pkgs, lib, ... }:
{
  programs.fish = {
    enable = true;
    plugins = with pkgs.fishPlugins; [
      {
        name = "tide";
        inherit (tide) src;
      }
      {
        name = "autopair";
        inherit (autopair) src;
      }
    ];

    interactiveShellInit = ''
      set fish_greeting

      if not set -q tide_left_prompt_frame_enabled
        tide configure --auto --style=Classic --prompt_colors='16 colors' --show_time=No --classic_prompt_separators=Vertical --powerline_prompt_heads=Sharp --powerline_prompt_tails=Flat --powerline_prompt_style='Two lines, character and frame' --prompt_connection=Disconnected --powerline_right_prompt_frame=Yes --prompt_spacing=Compact --icons='Few icons' --transient=No
      end
    '';
  };
}
