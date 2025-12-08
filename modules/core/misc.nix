# NixOS Module
{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    ripgrep
    fzf
    fd

    gcc
    rustc
    cargo
    neovim
    git
    yazi
  ];
}
