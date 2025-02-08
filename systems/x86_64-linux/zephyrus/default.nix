{
  imports = [
    ./disk-config.nix
  ];

  facter.reportPath = ./facter.json;

  core.hostname = "zephyrus";

  system = {
    enable = true;

    hardware = {
      amdgpu.integrated.enable = true;
      nvidia.enable = true;

      bluetooth.enable = true;
    };

    boot.plymouth.enable = true;

    networking.enable = true;
    pipewire.enable = true;

    services.location.enable = true;
  };

  desktop.noir.enable = true;

  themes = {
    enable = true;
    catppuccin.enable = true;
  };
}
