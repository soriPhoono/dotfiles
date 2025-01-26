{
  imports = [
    ./disk-config.nix
  ];

  core.hostname = "zephyrus";

  system = {
    hardware.bluetooth.enable = true;

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
