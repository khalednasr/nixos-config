# Home Manager Module
{ ... }:
{
  imports = [
    ./shell.nix
    ./git.nix
    ./nixvim.nix
    ./yazi.nix
    ./tmux.nix
    ./misc.nix
  ];
}
