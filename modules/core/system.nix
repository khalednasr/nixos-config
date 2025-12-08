# NixOS Module
{ inputs, pkgs, globals, locals, ... }: {
  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

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
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Nix-ld settings
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [ stdenv.cc.cc zlib ];

  # User configuration
  users.users.${globals.username} = {
    isNormalUser = true;
    description = "${globals.userDescription}";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh; # set default shell
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
    extraSpecialArgs = { inherit inputs; inherit globals; inherit locals;};
  };

  system.stateVersion = "${globals.stateVersion}";
}
