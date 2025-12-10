{ ... }:
{
  services.displayManager.ly = {
    enable = true;
    settings = {
      bigclock = "en";
      animation = "matrix";
      session_log = ".ly-session.log";
    };
  };
}
