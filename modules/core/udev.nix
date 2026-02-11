{ globals, ... }:
{
  services.udev.extraRules = ''
    # Original FT2232 VID:PID
    ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6010", MODE="664", GROUP="plugdev", TAG+="uaccess"

    # Microchip Technology, Inc. AX3 Composite Device 1.7
    ATTRS{idVendor}=="04d8", ATTRS{idProduct}=="0057", MODE="664", GROUP="plugdev", TAG+="uaccess"

    # Microchip Technology, Inc. CWA Bootloader
    ATTRS{idVendor}=="04d8", ATTRS{idProduct}=="003c", MODE="664", GROUP="plugdev", TAG+="uaccess"
  '';

  users.groups.plugdev = { };
  users.users.${globals.username}.extraGroups = [ "plugdev" ];
}
