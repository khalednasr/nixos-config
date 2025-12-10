# Home Manager Module
{ pkgs, lib, globals, ... }:
{
  programs.firefox = {
    enable = true;
  };

  home.packages = [
    pkgs.pywalfox-native
  ];

  home.activation = {
    pywalfox_setup = lib.hm.dag.entryAfter ["writeBoundary" "installPackages" "pywalfox-native"] ''
      export PATH="${lib.makeBinPath (with pkgs; [ pywalfox-native ])}:$PATH"
      pywalfox install
    '';
  };
}
