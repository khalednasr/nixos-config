{ pkgs, ... }:
{
  imports = [
    ../../modules/desktop/orcaslicer.nix
  ];

  environment.systemPackages = with pkgs; [
  ];
}
