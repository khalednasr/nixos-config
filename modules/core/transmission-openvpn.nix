# NixOS Module
{ globals, config, ... }:
let
  config_dir = "${globals.homeDir}/.transmission-openvpn";
  data_parent_dir = "${globals.homeDir}/Downloads";
  data_dir = "${data_parent_dir}/transmission";
  openvpn_credentials_file = "${globals.homeDir}/.vpn/nordvpn-openvpn.txt";
in
{
  virtualisation.oci-containers = {
    backend = "docker";

    containers.transmission-openvpn = {
      image = "haugene/transmission-openvpn";
      
      volumes = [ 
        "${config_dir}:/config"
        "${data_dir}:/data"
        "${openvpn_credentials_file}:/config/openvpn-credentials.txt"
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

  systemd.services.docker-transmission-openvpn.postStart = ''
    mkdir -p ${config_dir}
    mkdir -p ${data_parent_dir}
    mkdir -p ${data_dir}

    chown ${globals.username}:users ${config_dir}
    chown ${globals.username}:users ${data_parent_dir}
    chown ${globals.username}:users ${data_dir}

    chmod g+rwx ${config_dir}
    chmod g+rwx ${data_parent_dir}
    chmod g+rwx ${data_dir}
  '';
}
