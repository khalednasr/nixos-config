# NixOS Module
# Based on the NordVPN module in https://github.com/chaotic-cx
{ pkgs, globals, ... }:
let
  nordvpn = pkgs.callPackage ./nordvpn.nix { };
in
{
  environment.systemPackages = [
    nordvpn
  ];

  users.groups.nordvpn = { };
  systemd = {
    services.nordvpn = {
      description = "NordVPN daemon.";
      serviceConfig = {
        ExecStart = "${nordvpn}/bin/nordvpnd";
        ExecStartPre = pkgs.writeShellScript "nordvpn-start" ''
          mkdir -m 700 -p /var/lib/nordvpn;
          if [ -z "$(ls -A /var/lib/nordvpn)" ]; then
            cp -r ${nordvpn}/var/lib/nordvpn/* /var/lib/nordvpn;
          fi
        '';
        NonBlocking = true;
        KillMode = "process";
        Restart = "on-failure";
        RestartSec = 5;
        RuntimeDirectory = "nordvpn";
        RuntimeDirectoryMode = "0750";
        Group = "nordvpn";
      };
      wantedBy = [ "multi-user.target" ];
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
    };
  };

  networking.firewall.allowedTCPPorts = [ 1194 ];
  networking.firewall.allowedUDPPorts = [ 443 ];

  users.users.${globals.username}.extraGroups = [ "nordvpn" ];
}
