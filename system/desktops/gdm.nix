{ config, pkgs, ... }: {
  services.xserver.displayManager = {
    gdm = {
      enable = true;

      wayland = true;
    };

    defaultSession = "gnome";

    autoLogin = {
      enable = true;
      user = "soriphoono";
    };
  };
}
