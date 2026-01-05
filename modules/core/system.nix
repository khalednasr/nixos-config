# NixOS Module
{ inputs, pkgs, globals, locals, ... }:
{
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

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ0U3xU6tYLgE3+jtwSxj3D0Z1rS83CaaEPvaxJf/Th3 nasrk@yoyo"
    ];
  };

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ0U3xU6tYLgE3+jtwSxj3D0Z1rS83CaaEPvaxJf/Th3 nasrk@yoyo"
  ];

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
