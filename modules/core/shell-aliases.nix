# Home Manager Module
{ globals, locals, ... }:
{
  home.shellAliases = {
    cd = "z";

    nec = "cd ${globals.repoDir} && nvim";
    nrb = "sudo nixos-rebuild switch --flake path:${globals.repoDir}#${locals.hostName}";
    ncg = "nix-collect-garbage --delete-old && sudo nix-collect-garbage -d";

    nstatus = "cd ${globals.repoDir}; git status; cd -";
    npush = "cd ${globals.repoDir}; git add --all; git commit -m 'update'; git push; cd -";
    npull = "cd ${globals.repoDir}; git pull; cd -";
  };
}
