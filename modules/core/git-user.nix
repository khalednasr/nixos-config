# Home Manager Module
{ globals, ... }:
{
  programs.git = {
    settings = {
      user.name = "${globals.gitUsername}";
      user.email = "${globals.gitEmail}";
    };
  };
}
