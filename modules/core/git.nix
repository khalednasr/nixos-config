# NixOS Module
{ globals, ... }: {
  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      user.name = "${globals.gitUsername}";
      user.email = "${globals.gitEmail}";
      push.autoSetupRemote = true;
      url = { "https://github.com/" = { insteadOf = [ "gh:" "github:" ]; }; };
    };
  };

  programs.gh.enable = true;
}
