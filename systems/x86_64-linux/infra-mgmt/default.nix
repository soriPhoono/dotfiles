{
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/virtualisation/proxmox-lxc.nix")
  ];

  core = {
    secrets = {
      enable = true;
      defaultSopsFile = ./secrets.yaml;
    };

    networking = {
      network-manager.enable = true;
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

  sops = {
    secrets."hosting/tailscale/api_key" = {};
    templates."docker/tailscale.env".content = ''
      TS_AUTHKEY=${config.sops.placeholder."hosting/tailscale/api_key"}
    '';
  };

  virtualisation.oci-containers.containers = {
    portainer-server = {
      image = "portainer/portainer-ee:latest";
      volumes = [
        "portainer-server_data:/data"
      ];
      ports = [
        "9000:9000"
      ];
    };
    tailscale = {
      image = "tailscale/tailscale:stable";
      hostname = "cloud";
      devices = [
        "/dev/net/tun"
      ];
      capabilities = {
        NET_ADMIN = true;
        SYS_MODULE = true;
      };
      environment = {
        TS_AUTH_ONCE = true;
        TS_ACCEPT_DNS = true;
        TS_USERSPACE = false;
        TS_ENABLE_METRICS = true;
        TS_SERVE_CONFIG = "/tailscale-serve.json"
      };
      environmentFiles = [
        config.sops.templates."docker/tailscale.env".path
      ];
      volumes = [
        "${pkgs.writeTextFile "tailscale-serve.json" ''
          {
            "TCP": {
              "443": {
                "HTTPS": true
              }
            },
            "Web": {
              "admin.xerus-augmented.ts.net:443": {
                "Handlers": {
                  "/": {
                    "Proxy": "http://127.0.0.1:9000"
                  }
                }
              }
            }
          }''}:/tailscale-serve.json"

        "tailscale-config:/var/lib/tailscale"
      ];
    };
  };
}
