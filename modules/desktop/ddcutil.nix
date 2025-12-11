# NixOS Module
{ pkgs, globals, ... }:
{
  hardware.i2c.enable = true;
  users.groups.i2c = { };
  users.users.${globals.username}.extraGroups = [ "i2c" ];

  environment.systemPackages = [ pkgs.ddcutil ];
}
