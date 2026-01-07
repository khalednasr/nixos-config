rec {
  username = "nasrk";
  userDescription = "Khaled";
  gitUsername = "khalednasr";
  gitEmail = "k.nasr92@gmail.com";
  repoName = "nixos-config";
  homeDir = "/home/${username}";
  repoDir = "/home/${username}/${repoName}";

  keyboardLayout = "de";
  consoleKeyMap = "de";
  locale = "en_US.UTF-8";
  timeZone = "Europe/Berlin";

  shell = "fish";

  desktopShell = "dms";
  terminal = "kitty";
  browser = "firefox";

  stateVersion = "26.05";
}
