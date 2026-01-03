# NixOS Module
{ pkgs, locals, ... }:
{
  networking.hostName = "${locals.hostName}";

  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [
      networkmanager-openvpn
    ];
  };


  networking.firewall.enable = true;
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  services.avahi = {
    enable = true;
    nssmdns = true;
    # publish = {
    #   enable = true;
    #   addresses = true;
    #   domain = true;
    #   hinfo = true;
    #   userServices = true;
    #   workstation = true;
    # };
  };
}
