# Home Manager Module
{ globals, ... }:
{
  imports = [
    ../../modules/core/shell
    ../../modules/core/git.nix
    ../../modules/core/nixvim.nix
    ../../modules/core/yazi.nix
  ];

  home.username = "${globals.username}";
  home.homeDirectory = "${globals.homeDir}";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.stateVersion = "${globals.stateVersion}";
}
