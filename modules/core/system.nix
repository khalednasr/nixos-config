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
  };

  # Home manager
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
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
