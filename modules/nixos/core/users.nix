{ pkgs, ... }: {
  programs = {
    dconf.enable = true;
    fish.enable = true;
  };

  snowfallorg.users.soriphoono = { }; # Admin account creation

  users = {
    defaultUserShell = pkgs.fish;

    users.soriphoono.initialPassword = "hello";
  };
}
