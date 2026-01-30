# Home Manager Module
{ ... }:
{
  imports = [
    ./shell
    ./git.nix
    ./nixvim.nix
    ./yazi.nix
    ./tmux.nix
    ./misc.nix
  ];
}
