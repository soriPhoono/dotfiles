{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./secrets.nix

    ./shells/fish.nix
    ./shells/starship.nix

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
      bat.enable = true;
      eza = {
        enable = true;

        enableFishIntegration = config.programs.fish.enable;

        git = true;
        icons = "auto";

        extraOptions = [
          "--group-directories-first"
        ];
      };
      ripgrep.enable = true;

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
