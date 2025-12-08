# NixOS Module
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ripgrep
    fzf
    fd

    gcc
    git
    yazi
  ];
}
