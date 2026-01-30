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
    openFirewall = true;
  };

  environment.systemPackages = with pkgs; [
    wireguard-ui
    wireguard-tools
  ];
  networking.firewall.checkReversePath = "loose"; # For wireguard connections

  # For internet sharing with Network Manager
  networking.firewall.allowedUDPPorts = [ 53 67 ];
}
