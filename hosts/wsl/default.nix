{ config
, pkgs
, username
, ...
}: {
  wsl = {
    enable = true;
    defaultUser = "${username}";
  };

  documentation = {
    enable = false;
    man.enable = false;
    info.enable = false;
    nixos.enable = false;
  };

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

  time.timeZone = "America/Chicago";

  environment.systemPackages = with pkgs; [
    coreutils

    wget
  ];

  users.users.${username} = {
    name = "${username}";

    isNormalUser = true;

    shell = pkgs.zsh;
  };

  programs = {
    nix-ld = {
      enable = true;

      package = pkgs.nix-ld-rs;
    };

    command-not-found.enable = true;

    zsh.enable = true;
  };

  services.openssh = {
    enable = true;

    hostKeys = [
      {
        comment = "soriphoono ${config.networking.hostName}";

        path = "/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];

    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  nix = {
    package = pkgs.lix;

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

  system.stateVersion = "24.11";
}
