# Home Manager Module
{ globals, locals, ... }:
{
  imports = [
    ./${globals.shell}.nix
  ];

  home.shellAliases = {
    cd = "z";

    nec = "cd ${globals.repoDir} && nvim";

    nrb = (
      if locals.nixos then
        "sudo nixos-rebuild switch --flake path:${globals.repoDir}#${locals.hostName}"
      else 
        ''home-manager --extra-experimental-features "nix-command flakes" switch --flake path:${globals.repoDir}#${locals.hostName}''
    );

    ncg = (
      if locals.nixos then
        "nix-collect-garbage --delete-old && sudo nix-collect-garbage -d"
      else 
        "nix-collect-garbage --delete-old"
    );

    nstatus = "cd ${globals.repoDir}; git status; cd -";
    npush = "cd ${globals.repoDir}; git add --all; git commit -m 'update'; git push; cd -";
    npull = "cd ${globals.repoDir}; git pull; cd -";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  programs = {
    fzf = {
      enable = true;
      enableZshIntegration = (globals.shell == "zsh");
      enableFishIntegration = (globals.shell == "fish");
    };

    zoxide = {
      enable = true;
      enableZshIntegration = (globals.shell == "zsh");
      enableFishIntegration = (globals.shell == "fish");
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
      silent = true;
    };
  };
}
