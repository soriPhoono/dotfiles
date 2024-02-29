{ config, pkgs, ... }: {
  services.xserver = {
    enable = true;

    displayManager.defaultSession = "plasmawayland";
    displayManager.sddm = {
      enable = true;

      wayland.enable = true;
    };

    desktopManager.plasma5 = {
      enable = true;

      phononBackend = "gstreamer";
    };
  };
}
