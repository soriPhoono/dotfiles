{pkgs, ...}: {
  imports = [
    ./disko.nix
  ];

  networking.firewall.allowedTCPPorts = [47984 47989 48010];
  networking.firewall.allowedUDPPorts = [47998 47999 48000 48100 48200];

  services.udev.extraRules = ''
    # Allows Wolf to acces /dev/uinput
    KERNEL=="uinput", SUBSYSTEM=="misc", MODE="0660", GROUP="input", OPTIONS+="static_node=uinput"

    # Allows Wolf to access /dev/uhid
    KERNEL=="uhid", TAG+="uaccess"

    # Move virtual keyboard and mouse into a different seat
    SUBSYSTEMS=="input", ATTRS{id/vendor}=="ab00", MODE="0660", GROUP="input", ENV{ID_SEAT}="seat9"

    # Joypads
    SUBSYSTEMS=="input", ATTRS{name}=="Wolf X-Box One (virtual) pad", MODE="0660", GROUP="input"
    SUBSYSTEMS=="input", ATTRS{name}=="Wolf PS5 (virtual) pad", MODE="0660", GROUP="input"
    SUBSYSTEMS=="input", ATTRS{name}=="Wolf gamepad (virtual) motion sensors", MODE="0660", GROUP="input"
    SUBSYSTEMS=="input", ATTRS{name}=="Wolf Nintendo (virtual) pad", MODE="0660", GROUP="input"
  '';

  core = {
    boot.enable = true;

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
    };

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
        extraGroups = [ "input" ];
        publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEgxxFcqHVwYhY0TjbsqByOYpmWXqzlVyGzpKjqS8mO7";
      };
    };
  };

  hosting.docker.enable = true;
}
