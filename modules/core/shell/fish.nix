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
        name = "fzf";
        inherit (fzf) src;
      }
    ];

    interactiveShellInit = ''
      set fish_greeting

      if not set -q tide_left_prompt_frame_enabled
        tide configure --auto --style=Classic --prompt_colors='16 colors' --show_time=No --classic_prompt_separators=Vertical --powerline_prompt_heads=Sharp --powerline_prompt_tails=Flat --powerline_prompt_style='Two lines, character and frame' --prompt_connection=Solid --powerline_right_prompt_frame=No --prompt_spacing=Sparse --icons='Few icons' --transient=No
      end
    '';
  };

  # fzf plugin configuration
  home.activation.configure_fish_fzf = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    # Fzf configuration
    ${pkgs.fish}/bin/fish -c "set -U FZF_LEGACY_KEYBINDINGS 0"
    ${pkgs.fish}/bin/fish -c "set -U FZF_COMPLETE 2"
  '';
}
