{
  pkgs,
  config,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/virtualisation/proxmox-lxc.nix")
  ];

  fileSystems = {
    "/export/media" = {
      device = "/mnt/data/media"
    };
  };

  services.nfs.server = {
    enable = true;
    lockdPort = 4001;
    mountdPort = 4002;
    statdPort = 4000;
    extraNfsdConfig = '''';
  };

  networking.firewall = {
    allowedTCPPorts = [ 111  2049 4000 4001 4002 20048 ];
    allowedUDPPorts = [ 111 2049 4000 4001  4002 20048 ];
  };

  core = {
    secrets = {
      enable = true;
      defaultSopsFile = ./secrets.yaml;
    };

    networking = {
      network-manager.enable = true;
      tailscale = {
        enable = true;
        auth.enable = true;
        service = {
          enable = true;
          config = ''
            {
              "TCP": {
                "443": {
                  "HTTPS": true
                }
              },
              "Web": {
                "pvr.xerus-augmented.ts.net:443": {
                  "Handlers": {
                    "/": {
                      "Proxy": "http://127.0.0.1:${builtins.toString config.services.qbittorrent.webuiPort}"
                    }
                  }
                }
              }
            }
          '';
        };
      };
    };

    users = {
      soriphoono = {
        hashedPassword = "$6$x7n.SUTMtInzs2l4$Ew3Zu3Mkc4zvuH8STaVpwIv59UX9rmUV7I7bmWyTRjomM7QRn0Jt/Pl/JN./IqTrXqEe8nIYB43m1nLI2Un211";
        admin = true;
        shell = pkgs.fish;
        extraGroups = ["input"];
        publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEgxxFcqHVwYhY0TjbsqByOYpmWXqzlVyGzpKjqS8mO7";
      };
    };
  };

  hosting.docker.enable = true;
}
