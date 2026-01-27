# NixOS Module
{ globals, config, ... }:
{
  virtualisation.oci-containers = {
    backend = "docker";

    containers.transmission-openvpn = {
      image = "haugene/transmission-openvpn";
      
      volumes = [ 
        "${globals.homeDir}/Downloads/transmission:/data"
        "${globals.homeDir}/.transmission-openvpn:/config"
        "${globals.homeDir}/.vpn/nordvpn-openvpn.txt:/config/openvpn-credentials.txt"
      ];

      environment = {
        OPENVPN_PROVIDER = "NORDVPN";
        OPENVPN_USERNAME = "**None**";
        OPENVPN_PASSWORD = "**None**";
        NORDVPN_COUNTRY = "netherlands";
        LOCAL_NETWORK = "192.168.0.0/16";
        PUID = toString(globals.userUID);
        PGID = toString(config.users.groups.users.gid);
      };

      extraOptions = [
        "--cap-add=NET_ADMIN"
        "--log-driver=json-file"
        "--log-opt=max-size=10m"
      ];

      ports = [
        "9091:9091"
      ];
    };
  };

  networking.firewall.allowedTCPPorts = [ 9091 ];
}
