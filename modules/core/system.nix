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
    uid = globals.userUID;
    isNormalUser = true;
    description = "${globals.userDescription}";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.${globals.shell}; # set default shell
    ignoreShellProgramCheck = true;

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMHL6+vtrOsjN4WC1PW+/eCBPmXSLUwjvtgakT22/hXk nasrk@yoyo"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOm0mlC0thnDtCGuUwyscbnbVMzQUd6b6pFtpEiTRdt3 nasrk@numerino"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL+sDL0yYN9ZpprywzEe2FhEoVhxD29ufj4b5MYq5L/A nasrk@toobig"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEsh8qoWRNPG1j6dY0bHzTiW/0c1kphmx+RgTLpGw59l"
    ];
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
