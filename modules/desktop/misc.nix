# NixOS Module
{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    maple-mono.truetype
    maple-mono.NF-unhinted
    maple-mono.NF-CN-unhinted
    fira-code
    fira-code-symbols
    ubuntu-sans
    ubuntu-sans-mono
    ubuntu-classic
  ];

  environment.systemPackages = with pkgs; [
    filezilla
    caligula
    onlyoffice-desktopeditors
  ];

  services.printing = {
    enable = true;
    drivers = with pkgs; [
      cups-filters
      cups-browsed
    ];
  };
}
