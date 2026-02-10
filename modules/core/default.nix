# NixOS Module
{ globals, locals, ... }:
{
  # NixOS modules
  imports = [
    ./system.nix
    ./network.nix
  ]
  ++ (if locals.virtualization then [ ./virtualization.nix ] else [ ]);

  # Home manager modules
  home-manager.users.${globals.username}.imports = [
    ./devtools
    ./shell-aliases.nix
    ./git-user.nix
    ./syncthing.nix
  ];
}
