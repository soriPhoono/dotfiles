{
  networking.hostName = "zephyrus";

  system = {
    hardware = {
      enable = true;
      amdgpu.integrated.enable = true;
      nvidia.enable = true;
    };

    disk = {
      enable = true;
      hostId = "7dc588ff";
    };

    impermanence.enable = true;

    boot = {
      enable = true;
      plymouth.enable = true;
    };

    power.enable = true;

    secrets.enable = true;

    networking.enable = true;
    bluetooth.enable = true;

    audio.enable = true;

    location.enable = true;
  };

  desktop.noir.enable = true;

  themes = {
    enable = true;
    catppuccin.enable = true;
  };
}
