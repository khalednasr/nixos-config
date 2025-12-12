# NixOS Module
{ locals, globals, ... }:
{
  # NixOS modules
  imports = [
    ./greeter
    ./niri
    ./services.nix
    ./bluetooth.nix
    ./ddcutil.nix
    ./social.nix
    ./misc.nix
  ]
  ++ (if locals.laptop then [ ./laptop.nix ] else [ ]);

  # Home manager modules
  home-manager.users.${globals.username}.imports = [
    ./shell
    ./kitty.nix
    ./firefox.nix
  ];
}
