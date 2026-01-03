# Home Manager Module
{ lib, globals, ... }:
{
  imports = [
    ../../modules/core/shell
    ../../modules/core/git.nix
    ../../modules/core/nixvim.nix
    ../../modules/core/yazi.nix
  ];

  programs.home-manager.enable = true;
  home.username = "${globals.username}";
  home.homeDirectory = "${globals.homeDir}";
  home.stateVersion = "${globals.stateVersion}";

  home.activation = {
    set_default_shell = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      SHELL_PATH="${globals.homeDir}/.nix-profile/bin/${globals.shell}"
      ETC_SHELLS="/etc/shells"
      grep -qF -- "$SHELL_PATH" "$ETC_SHELLS" || echo "$SHELL_PATH" | /bin/sudo tee -a "$ETC_SHELLS" > /dev/null
      /bin/sudo /bin/chsh -s $SHELL_PATH ${globals.username}
    '';
  };

  programs."${globals.shell}".shellInit = ''
    source ${globals.homeDir}/.nix-profile/etc/profile.d/nix.${if globals.shell=="fish" then "fish" else "sh"}
  '';
}
