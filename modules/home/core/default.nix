{ pkgs, ... }: {
  imports = [
    ./secrets.nix

    ./shells/fish.nix
    ./shells/starship.nix

    ./programs/btop.nix
    ./programs/fastfetch.nix
    ./programs/git.nix
    ./programs/eza.nix
    ./programs/direnv.nix
  ];

  config = {
    xdg = {
      enable = true;
      userDirs = {
        enable = true;

        createDirectories = true;
      };
    };

    snowfallorg.user.enable = true;

    programs.home-manager.enable = true;

    home.stateVersion = "25.05";
  };
}
