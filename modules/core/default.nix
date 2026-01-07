# NixOS Module
{ globals, locals, ... }:
{
  # NixOS modules
  imports = [
    ./system.nix
    ./network.nix
    ./virtualization.nix
    ./misc.nix
  ]
  ++ (if locals.nordvpn then [ ./nordvpn ] else [ ]);

  # Home manager modules
  home-manager.users.${globals.username}.imports = [
    ./shell
    ./git.nix
    ./nixvim.nix
    ./yazi.nix
    ./tmux.nix
  ];
}
