{
  imports = [
    ./fastfetch.nix
    ./git.nix
    ./starship.nix
  ];

  core = {
    secrets = {
      defaultSopsFile = ./secrets.yaml;
    };

    shells.shellAliases = {
      v = "nix run github:soriPhoono/nvim/nixos#soriphoono";
    };
  };

  sops.secrets.age_key.path = "$HOME/.config/sops/age/keys.txt"

  programs = {
    fish.shellInitLast = ''
      fastfetch
    '';

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    eza = {
      enable = true;

      git = true;
      icons = "auto";

      extraOptions = [
        "--group-directories-first"
      ];
    };

    btop.enable = true;
  };
}
