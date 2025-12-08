# Home Manager Module
{ pkgs, globals, locals, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history.size = 10000;

    plugins = [
      {
        name = "fzf-tab";
        src = "${pkgs.zsh-fzf-tab}/share/fzf-tab";
      }
      {
        name = "zsh-autopair";
        src = "${pkgs.zsh-autopair}/share/zsh/zsh-autopair";
        file = "autopair.zsh";
      }
    ];

    oh-my-zsh = {
      enable = true;
      theme = "gnzh";
    };

    shellAliases = {
      nec = "cd ${globals.repoDir} && nvim .";
      nrb = "sudo nixos-rebuild switch --flake path:${globals.repoDir}#${locals.hostName}";
      ncg = "nix-collect-garbage --delete-old && sudo nix-collect-garbage -d";
    };
  };

  programs.fzf.enable = true;
  programs.fzf.enableZshIntegration = true;

  programs.direnv.enable = true;
  programs.direnv.enableZshIntegration = true;
  programs.direnv.silent = true;
}
