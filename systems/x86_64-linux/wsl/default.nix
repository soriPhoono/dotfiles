{ pkgs, ... }: {
  i18n = {
    defaultLocale = "en_US.UTF-8";

    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  time.timeZone = lib.mkDefault "America/Chicago";

  environment.systemPackages = with pkgs; [
    coreutils

    wget
  ];

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
