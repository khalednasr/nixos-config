# Home Manager Module
{ ... }:
{
  programs.kitty = {
    enable = true;
    font.name = "Maple Mono";

    # Include Nocatalia theme
    extraConfig = ''
      include current-theme.conf
    '';
  };
}
