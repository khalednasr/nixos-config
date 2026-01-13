# NixOS Module
{ pkgs, globals, ... }:
{
  boot.supportedFilesystems = [ "ntfs" ];

  environment.systemPackages = [ pkgs.rclone ];
  environment.etc."rclone-mnt.conf".text = ''
    [boxypi]
    type = sftp
    host = boxypi
    user = ${globals.username}
    key_file = /home/${globals.username}/.ssh/id_ed25519
  '';

  fileSystems."/mnt/share" = {
    device = "boxypi:/home/${globals.username}/share";
    fsType = "rclone";
    options = [
      "nodev"
      "nofail"
      "allow_other"
      "args2env"
      "config=/etc/rclone-mnt.conf"
    ];
  };
}
