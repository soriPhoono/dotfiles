{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.hyprland;
in {
  options.desktop.hyprland = {
    enable = lib.mkEnableOption "Enable hyprland installation";
  };

  config = lib.mkIf cfg.enable {
    programs = {
      hyprland.enable = true;

      hyprlock.enable = true;
    };

    services = {
      xserver = {
        enable = true;

        xkb.layout = "us";
        xkb.variant = "";

        displayManager.sddm.enable = true;
      };

      hypridle.enable = true;
    };
  };
}
