# NixOS Module
{ locals, ... }:
{
  imports = [
    ./steam.nix
  ]
  ++ (if locals.sunshine then [ ./sunshine.nix ] else [ ]);

  programs.gamemode.enable = true;
}
