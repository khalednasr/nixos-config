{ pkgs, globals, ... }:
{
  users.groups.data = { };
  users.users."${globals.username}".extraGroups = [ "data" ];

  users.users.ece = {
    isNormalUser = true;
    description = "Ece";
    shell = pkgs.${globals.shell};
    ignoreShellProgramCheck = true;
    extraGroups = [ "data" ];

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMHL6+vtrOsjN4WC1PW+/eCBPmXSLUwjvtgakT22/hXk nasrk@yoyo"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOm0mlC0thnDtCGuUwyscbnbVMzQUd6b6pFtpEiTRdt3 nasrk@numerino"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL+sDL0yYN9ZpprywzEe2FhEoVhxD29ufj4b5MYq5L/A nasrk@toobig"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEsh8qoWRNPG1j6dY0bHzTiW/0c1kphmx+RgTLpGw59l"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICyEkR4S+WkAnpJsHI04mMJoap+V8jk4Flkdqc4zee9x ece.guzelkokar@Eces-MacBook-Air.local"
    ];

    initialHashedPassword = "$y$j9T$LQGkTFP.XP7L7VeP9BDpZ.$xfFI1QGoQXfMt3BkQwZZgvAxwpktOdxITJJH10AqE1C";
  };

  home-manager.users.ece = {
    imports = [ ../../modules/core/devtools ];

    home = {
      username = "ece";
      homeDirectory = "/home/ece";
      stateVersion = "${globals.stateVersion}";
    };

    programs.gh.enable = true;
  };

  networking.firewall.allowedTCPPorts = [ 8888 ]; # jupyter
}
