# NixOS Module
{ inputs, globals, ... }:
{
  imports = [
    inputs.dankMaterialShell.nixosModules.greeter
  ];

  programs.dank-material-shell.greeter = {
    enable = true;
    compositor.name = "niri";
    configHome = "${globals.homeDir}";

    logs = {
      save = true; 
      path = "/tmp/dms-greeter.log";
    };
  };
}
