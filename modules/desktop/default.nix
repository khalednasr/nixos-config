# NixOS Module
{ locals, ... }: { 
  imports = [
    ./niri.nix
    ./misc.nix
  ]
  ++ (if locals.laptop then [ ./laptop.nix ] else []);
}
