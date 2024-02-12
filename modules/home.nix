{ username, ... }: {
  imports = [
    ./user

    ./user/cli/zsh.nix
    ./user/desktop/hyprland.nix
  ];

  programs = {
    home-manager.enable = true;
  };

  xdg = {
    enable = true;

    # TODO: migrate this to desktop level unless file type is strictly cli accessable
    mime.enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "image/png" = "imv.desktop";
      };
    };

    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };

  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";

    stateVersion = "23.11";
  };
}
