# NixOS Module
{ pkgs, globals, ... }:
{
  # Display manager
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet -t -r -c niri-session -w 40";
      };
    };
  };

  # System services
  services.udisks2.enable = true;

  # User services
  home-manager.users.${globals.username} = {
    services.udiskie.enable = true;
  };
}
