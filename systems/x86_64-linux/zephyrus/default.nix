{
  imports = [
    ./disko.nix
  ];

  core = {
    hardware = {
      enable = true;
      reportPath = ./facter.json;

      gpu = {
        integrated.amd.enable = true;
        dedicated.nvidia.enable = true;
      };

      bluetooth.enable = true;
    };

    boot.enable = true;

    networking = {
      enable = true;
      network-manager.enable = true;
      tailscale.enable = true;
    };
  };

  desktop.plasma.enable = true;

  themes.catppuccin.enable = true;
}
