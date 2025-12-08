# NixOS Module
{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    ghostty
    qutebrowser
  ];
}
