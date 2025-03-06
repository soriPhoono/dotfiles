{pkgs, ...}: {
  imports = [
    ./secrets.nix

    ./shells/fish.nix
    ./shells/starship.nix

    ./programs/atuin.nix
    ./programs/fastfetch.nix
    ./programs/fd.nix
    ./programs/fzf.nix
    ./programs/git.nix
    ./programs/eza.nix
    ./programs/direnv.nix
    ./programs/programs.nix
  ];

  config = {
    home.packages = with pkgs; [
      zip
      unzip

      unrar
    ];

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
