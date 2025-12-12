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
    ./zsh.nix
    ./git.nix
    ./nixvim.nix
    ./yazi.nix
    ./dev.nix
  ];
}
