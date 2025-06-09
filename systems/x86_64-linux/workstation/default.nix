{pkgs, ...}: {
  imports = [
    ./disko.nix
  ];

  core = {
    hardware = {
      enable = true;
      reportPath = ./facter.json;

      gpu = {
        integrated.intel = {
          enable = true;
          deviceId = "a780";
        };
        dedicated.amd.enable = true;
      };

      hid = {
        logitech.enable = true;
        qmk.enable = true;
        xbox_controllers.enable = true;
      };

      bluetooth.enable = true;
    };

    boot.enable = true;

    secrets.defaultSopsFile = ./secrets.yaml;

    networking = {
      enable = true;
      network-manager.enable = true;
      tailscale = {
        enable = true;
        tn_name = "xerus-augmented.ts.net";
      };
    };

    users = {
      soriphoono = {
        email = "soriphoono@gmail.com";
        hashedPassword = "$6$x7n.SUTMtInzs2l4$Ew3Zu3Mkc4zvuH8STaVpwIv59UX9rmUV7I7bmWyTRjomM7QRn0Jt/Pl/JN./IqTrXqEe8nIYB43m1nLI2Un211";
        admin = true;
        shell = pkgs.fish;
        publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEgxxFcqHVwYhY0TjbsqByOYpmWXqzlVyGzpKjqS8mO7";
      };
    };
  };

  desktop = {
    environments.gnome.enable = true;
    features.gaming = {
      enable = true;
      featureType = ["desktop" "vr"];
    };
  };

  server = {
    enable = true;

    nextcloud.enable = true;
    multimedia.enable = true;

    ollama.enable = true;

    mailserver.host = "smtp.gmail.com";

    users = {
      soriphoono = {
        first_name = "Sori";
        last_name = "Phoono";
        password_hash = "{SSHA}9Et7vT4i7MPOsM6FPPYvZdzqBzkfdOGU";
        email = "soriphoono@protonmail.com";

        groups = [
          "nextcloud_users"
          "multimedia_users"
          "chat_users"
        ];
      };
    };
  };

  themes.catppuccin.enable = true;
}
