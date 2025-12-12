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

  desktopGreeter = "tuigreet";
  desktopShell = "dms";

  stateVersion = "26.05";
}
