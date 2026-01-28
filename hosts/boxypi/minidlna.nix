# NixOS Module
{ globals, config, ... }:
let
  config_dir = "${globals.homeDir}/.minidlna";
  media_dir = "${globals.homeDir}/Downloads/transmission/completed";
in
{
  virtualisation.oci-containers = {
    backend = "docker";

    containers.minidlna = {
      image = "vladgh/minidlna";

      volumes = [
        "${config_dir}:/config"
        "${media_dir}:/media"
      ];

      environment = {
        PUID = toString (globals.userUID);
        PGID = toString (config.users.groups.users.gid);
        MINIDLNA_MEDIA_DIR = "/media";
        MINIDLNA_FRIENDLY_NAME = "BoxyPI";
      };

      extraOptions = [
        "--net=host"
      ];

      ports = [
        "8200:8200"
      ];
    };
  };

  networking.firewall.allowedTCPPorts = [ 8200 ];
}
