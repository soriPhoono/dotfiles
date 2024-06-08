{ ... }: {
  services.displayManager.sddm = {
    enable = true;

    wayland = {
      enable = true;

      compositor = "weston";
    };
  };

  services.desktopManager.plasma6.enable = true;
}