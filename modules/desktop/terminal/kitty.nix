# Home Manager Module
{ globals, ... }:
{
  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    font.name = "Maple Mono";

    settings = {
      confirm_os_window_close = 0;
    };

    keybindings = {
      "alt+t" = "new_os_window_with_cwd";
    };

    extraConfig = (
      if globals.desktopShell == "noctalia" then
        ''
          include current-theme.conf
        ''
      else if globals.desktopShell == "dms" then
        ''
          include dank-theme.conf
          include dank-tabs.conf
        ''
      else
        ''''
    );
  };

  home.shellAliases = {
    "ssh" = "kitten ssh";
  };
}
