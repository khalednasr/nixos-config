# Home Manager Module
{ pkgs, ... }:
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
        tide configure --auto --style=Lean --prompt_colors='16 colors' --show_time=No --lean_prompt_height='Two lines' --prompt_connection=Disconnected --prompt_spacing=Compact --icons='Few icons' --transient=No
      end
    '';
  };

  programs = {
    fzf = {
      enable = true;
      enableFishIntegration = true;
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
      silent = true;
    };
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];
}
