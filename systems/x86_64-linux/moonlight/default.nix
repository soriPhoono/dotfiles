{
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/virtualisation/proxmox-lxc.nix")
  ];

  core = {
    hardware.gpu.dedicated.amd.enable = true;

    secrets = {
      enable = true;
      defaultSopsFile = ./secrets.yaml;
    };

    networking = {
      network-manager.enable = true;
      tailscale.enable = true;
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

  networking.firewall.allowedTCPPorts = [48010 47989 47984];
  networking.firewall.allowedUDPPorts = [47999 48100 48200];

  virtualisation.oci-containers = {
    backend = "docker";

    containers = {
      wolf-server = {
        image = "ghcr.io/games-on-whales/wolf:stable";
        volumes = [
          "wolf-config:/etc/wolf"
          "/var/run/docker.sock:/var/run/docker.sock:rw"
          "/dev:/dev:rw"
          "/run/udev:/run/udev:rw"
          "/mnt/games:/mnt/games:rw"
        ];
        environment = {
          WOLF_RENDER_NODE = "/dev/dri/renderD129";
        };
        extraOptions = ["--device-cgroup-rule=c 13:* rmw"];
        devices = [
          "/dev/dri"
          "/dev/uinput"
          "/dev/uhid"
        ];
        ports = [
          "47984:47984/tcp"
          "47989:47989/tcp"
          "48010:48010/tcp"
          "47999:47999/udp"
          "48100:48100/udp"
          "48200:48200/udp"
        ];
      };
    };
  };
}
