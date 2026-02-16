# NixOS Module
{ pkgs, globals, ... }:
{
  virtualisation.docker.enable = true;
  virtualisation.oci-containers.backend = "docker";
  virtualisation.spiceUSBRedirection.enable = true;
  users.users.${globals.username}.extraGroups = [ "docker" ];

  environment.systemPackages = with pkgs; [
    distrobox
    quickemu
  ];
}
