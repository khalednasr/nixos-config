# Home Manager Module
{ globals, ... }:
{
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
  };

  home.file.".config/ghostty/config".text = ''
    font-family = Maple Mono
    window-inherit-working-directory = false
    working-directory = home
    shell-integration-features = ssh-terminfo,ssh-env
  ''
  + (
    if globals.desktopShell == "dms" then
      "config-file = config-dankcolors"
    else if globals.desktopShell == "noctalia" then
      "theme = noctalia"
    else
      ""
  );
}
