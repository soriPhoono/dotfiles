{ config, pkgs, ... }: {
  services.xserver = {
    enable = true;

    layout = "us";
    xkbVariant = "";

    libinput.enable = true;

    videoDrivers = [ "modesetting" "nvidia" ];

    displayManager = {
      gdm.enable = true;

      defaultSession = "gnome";

      autoLogin = {
        enable = true;
        user = "soriphoono";
      };
    };

    desktopManager = {
      gnome.enable = true;
    };
  };
}
