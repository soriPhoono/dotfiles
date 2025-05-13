{
  imports = [
    ./disko.nix
  ];

  core = {
    hardware = {
      enable = true;
      reportPath = ./facter.json;

      gpu.enable = true;

      bluetooth.enable = true;
    };

    boot.enable = true;

    secrets = {
      enable = true;
      defaultSopsFile = ./secrets.yaml;
    };

    networking = {
      enable = true;
      network-manager.enable = true;
      tailscale = {
        enable = true;
        autoLogin = true;
      };
    };
  };

  desktop.plasma.enable = true;

  themes.catppuccin.enable = true;
}
