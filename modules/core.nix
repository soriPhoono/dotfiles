{ config
, lib
, pkgs
, username
, ...
}: {
  imports = [
    ./users.nix
  ];

  time.timeZone = lib.mkDefault "America/Chicago";

  users.users.${username} = {
    name = "${username}";

    isNormalUser = true;

    shell = pkgs.fish;
  };

  environment.systemPackages = with pkgs; [
    coreutils
  ];

  programs = {
    fish.enable = true;

    command-not-found.enable = true;
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
  
  system.stateVersion = lib.mkDefault "24.11";
}
