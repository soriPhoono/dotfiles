{ lib, config, pkgs, ... }: {
  programs = {
    nix-index-database.comma.enable = true;

    fish.enable = true;

    dconf.enable = true;

    nix-ld = {
      enable = true;

      package = pkgs.nix-ld-rs;
    };
  };

  services.openssh = {
    enable = true;

    hostKeys = [
      {
        comment = "soriphoono ${config.networking.hostName}";

        path = "/etc/shh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];

    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  snowfallorg.users.soriphoono = {
    create = true;
    admin = true;

    home = {
      enable = true;

      config = {

      };
    };
  };

  nix = {
    settings = {
      auto-optimise-store = true;

      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };

    optimise = {
      dates = [
        "daily"
      ];
      automatic = true;
    };

    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 2d";
    };
  };
}
