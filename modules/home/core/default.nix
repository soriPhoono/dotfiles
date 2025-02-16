{pkgs, ...}: {
  imports = [
    ./secrets.nix

    ./shells/fish.nix
    ./shells/nushell.nix
    ./shells/starship.nix

    ./programs/atuin.nix
    ./programs/fastfetch.nix
    ./programs/fd.nix
    ./programs/fzf.nix
    ./programs/git.nix
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

    programs = {
      carapace.enable = true;

      bat.enable = true;

      eza = {
        enable = true;

        git = true;
        icons = "auto";

        extraOptions = [
          "--group-directories-first"
        ];
      };

      direnv = {
        enable = true;

        nix-direnv.enable = true;
      };

      btop.enable = true;

      home-manager.enable = true;
    };

    home.stateVersion = "25.05";
  };
}
