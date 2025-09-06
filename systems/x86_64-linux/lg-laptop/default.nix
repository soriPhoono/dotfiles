{pkgs, ...}: {
  imports = [
    ./disko.nix
  ];

  core = {
    hardware = {
      enable = true;
      reportPath = ./facter.json;

      gpu = {
        integrated.intel.enable = true;
      };

      hid = {
        tablet.enable = true;
        xbox_controllers.enable = true;
      };

      bluetooth.enable = true;
    };

    boot.enable = true;

    secrets.defaultSopsFile = ./secrets.yaml;

    networking = {
      enable = true;
      network-manager.enable = true;
      tailscale.enable = true;
    };

    users = {
      spookyskelly = {
        hashedPassword = "$y$j9T$2ClMbK8AGR2tDvxqsQi7N/$VoJZOzxRwbq6GZ9zBR0E2gq0GsZ3Oo27RcjCyG/Gct5";
        admin = true;
        shell = pkgs.fish;
        publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDMKr5+AriekN7pqmK2bIAWbYqulnxTHL56+dB9Od6vs";
      };
    };
  };

  desktop = {
    environments.gnome.enable = true;
    features.gaming.enable = true;
  };

  themes.catppuccin.enable = true;
}
