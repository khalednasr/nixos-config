# NixOS Module
{ inputs, pkgs, ... }:
{
  services.xserver = {
    enable = true;

    windowManager.oxwm.enable = true;
  };

  services.xserver.displayManager.lightdm.enable = true;

  environment.systemPackages = with pkgs; [
    alacritty
  ];
}
