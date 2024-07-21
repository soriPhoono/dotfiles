{ pkgs, ... }: {
  programs.fish.enable = true;

  users.defaultUserShell = pkgs.fish;

  snowfallorg.users.soriphoono = {
    create = true;
    admin = true;

    home.enable = true;
  };
}
