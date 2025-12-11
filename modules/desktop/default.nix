# NixOS Module
{ locals, globals, ... }:
{
  # NixOS modules
  imports = [
    ./services.nix
    ./niri
    ./bluetooth.nix
    ./social.nix
    ./misc.nix
  ]
  ++ (if locals.laptop then [ ./laptop.nix ] else [ ]);

  # Home manager modules
  home-manager.users.${globals.username}.imports = [
    ./noctalia.nix
    ./kitty.nix
    ./firefox.nix
  ];
}
