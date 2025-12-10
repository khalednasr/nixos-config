# NixOS Module
{ locals, globals, ... }:
{
  # NixOS modules
  imports = [
    ./ly.nix
    ./niri
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
