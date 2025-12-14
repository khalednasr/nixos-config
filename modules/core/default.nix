# NixOS Module
{ globals, ... }:
{
  # NixOS modules
  imports = [
    ./system.nix
    ./network.nix
    ./misc.nix
  ];

  # Home manager modules
  home-manager.users.${globals.username}.imports = [
    ./shell
    ./git.nix
    ./nixvim.nix
    ./yazi.nix
    ./zellij.nix
  ];
}
