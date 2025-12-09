{
  hostName = "yoyo";
  laptop = true;

  niriDisplayConfig = ''
    output "eDP-2" {
      mode "3072x1920@120.002"
      scale 1.75
    }
  '';

  amdgpuID = "PCI:4:0:0";
  nvidiaID = "PCI:1:0:0";
}
