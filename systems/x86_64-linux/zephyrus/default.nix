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
    };

    boot = {
      secure-boot.enable = true;
      plymouth.enable = true;
    };

    networking.enable = true;
    bluetooth.enable = true;

    pipewire.enable = true;

    location.enable = true;
  };

  desktop.noir.enable = true;

  themes = {
    enable = true;
    catppuccin.enable = true;
  };
}
