{ globals, ... }:
{
  # System services
  services.udisks2.enable = true;

  # User services
  home-manager.users.${globals.username} = {
    services.udiskie.enable = true;
  };
}
