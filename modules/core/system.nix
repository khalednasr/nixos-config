# NixOS Module
{
  inputs,
  pkgs,
  globals,
  locals,
  ...
}:
{
  boot = {
    # Bootloader.
    loader.grub.enable = true;
    loader.grub.device = "nodev";
    loader.grub.useOSProber = true;
    loader.grub.efiSupport = true;
    loader.grub.fontSize = 42;
    loader.efi.canTouchEfiVariables = true;

    # Kernel
    kernelPackages = pkgs.linuxPackages_zen;

    # Emulated cross-compilation
    binfmt.emulatedSystems = [ "aarch64-linux" ];
  };

  # Time zone and internationalisation properties
  time.timeZone = "${globals.timeZone}";
  i18n.defaultLocale = "${globals.locale}";

  # Keyboard layouts
  console.keyMap = "${globals.consoleKeyMap}";
  services.xserver.xkb = {
    layout = "${globals.keyboardLayout}";
    variant = "";
  };

  # Nix settings
  nix = {
    settings = {
      download-buffer-size = 200000000;
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [ "root" "${globals.username}" ];
    };
  };

  # programs.nix-ld = {
  #   enable = true;
  #   libraries = with pkgs; [
  #     zlib zstd stdenv.cc.cc curl openssl attr libssh bzip2 libxml2 acl libsodium util-linux xz systemd
  #   ];
  # };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # User configuration
  users.users.${globals.username} = {
    isNormalUser = true;
    description = "${globals.userDescription}";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.${globals.shell}; # set default shell
    ignoreShellProgramCheck = true;
  };

  # Home manager
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = false;
    backupFileExtension = "backup";
    users.${globals.username} = {
      home = {
        username = "${globals.username}";
        homeDirectory = "/home/${globals.username}";
        stateVersion = "${globals.stateVersion}";
      };
    };
    extraSpecialArgs = {
      inherit inputs;
      inherit globals;
      inherit locals;
    };
  };

  system.stateVersion = "${globals.stateVersion}";
}
