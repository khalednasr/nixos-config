# Home Manager Module
{ globals, locals, ... }: {
  home.sessionVariables = {
    EDITOR = "nvim";

    NIXOS_CONFIG_DIR = "${globals.repoDir}";
  };
}
