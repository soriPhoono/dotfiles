_: {
  networking.hostName = "nixos";

  system = {
    boot = {
      enable = true;
      plymouth.enable = true;
    };

    networking.enable = true;

    bluetooth.enable = true;

    pipewire.enable = true;

    location.enable = true;
  };

  themes = {
    enable = true;
    catppuccin.enable = true;
  };
}
