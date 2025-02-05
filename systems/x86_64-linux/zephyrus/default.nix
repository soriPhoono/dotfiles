{
  imports = [
    ./disk-config.nix
  ];

  facter.reportPath = ./facter.json;

  core.hostname = "zephyrus";

  system = {
    hardware = {
      amdgpu.integrated.enable = true;

      nvidia.enable = true;

      bluetooth.enable = true;
    };

    boot = {
      enable = true;
    };

    networking = {
      enable = true;
      networkmanager.enable = true;
    };

    pipewire.enable = true;
    power.enable = true;
  };

  desktop.noir.enable = true;

  themes = {
    enable = true;
    catppuccin.enable = true;
  };
}
