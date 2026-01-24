# NixOS Module
{ locals, globals, ... }:
{
  # NixOS modules
  imports = [
    ./shell
    ./services.nix
    ./bluetooth.nix
    ./ddcutil.nix
    ./orcaslicer.nix
    ./misc.nix
  ]
  ++ (if locals.laptop then [ ./laptop.nix ] else [ ])
  ++ (if locals.gaming then [ ./gaming ] else [ ])
  ++ (if locals.social then [ ./social.nix ] else [ ]);

  # Home manager modules
  home-manager.users.${globals.username}.imports = [
    ./terminal
    ./browser
  ];
}
