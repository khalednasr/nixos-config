# NixOS Module
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ripgrep
    fzf
    fd
    btop
    gcc
    devenv
    nix-index
  ];
}
