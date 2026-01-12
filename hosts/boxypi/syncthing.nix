
{ globals, lib, ... }:
{
  home-manager.users.${globals.username}.services.syncthing = {
    enable = lib.mkForce true;
    guiAddress = "0.0.0.0:8384";
  };

  networking.firewall.allowedTCPPorts = [ 8384 22000 ];
  networking.firewall.allowedUDPPorts = [ 22000 21027 ];
}
