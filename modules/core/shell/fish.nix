# Home Manager Module
{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
    plugins = [
      {
        name = "fzf";
        src = pkgs.fetchFromGitHub {
          owner = "jethrokuan";
          repo = "fzf";
          rev = "479fa67d7439b23095e01b64987ae79a91a4e283";
          sha256 = "sha256-28QW/WTLckR4lEfHv6dSotwkAKpNJFCShxmKFGQQ1Ew=";
        };
      }
    ];

    interactiveShellInit = ''
      set -U FZF_LEGACY_KEYBINDINGS 0
      set -U FZF_COMPLETE 2
    '';
  };
}
