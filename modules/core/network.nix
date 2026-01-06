# NixOS Module
{ pkgs, locals, ... }:
{
  networking = {
    hostName = "${locals.hostName}";

    networkmanager = {
      enable = true;
      plugins = with pkgs; [
        networkmanager-openvpn
      ];
    };

    firewall.enable = true;
  };

  services.openssh = {
    enable = true;
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };

  services.syncthing = {
    enable = true;
  };
}
