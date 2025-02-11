{lib, ...}: {
  networking.wireless.enable = lib.mkForce false;

  system = {
    boot = {
      enable = true;
      plymouth.enable = true;
    };

    networking.enable = true;

    bluetooth.enable = true;

    audio.enable = true;

    location.enable = true;
  };

  themes = {
    enable = true;
    catppuccin.enable = true;
  };
}
