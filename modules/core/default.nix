# NixOS Module
{ globals, ... }:
{
  # NixOS modules
  imports = [
    ./system.nix
    ./network.nix
    ./virtualization.nix
    ./nordvpn.nix
  ];

  # Home manager modules
  home-manager.users.${globals.username}.imports = [
    ./devtools
    ./shell-aliases.nix
    ./git-user.nix
    ./syncthing.nix
  ];
}
