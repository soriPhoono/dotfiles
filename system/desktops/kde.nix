{ config, pkgs, ... }: {
  services.xserver = {
    enable = true;

    displayManager.sddm = {
      enable = true;

      defaultSession = "plasmawayland";

      wayland.enable = true;
    };

    desktopManager.plasma5 = {
      enable = true;

      phononBackend = "gstreamer";
    };
  };
}
