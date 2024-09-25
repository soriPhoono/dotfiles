{ inputs
, lib
, pkgs
, config
, ...
}:
let cfg = config.desktop.hyprland;
in {
  options = {
    desktop.hyprland.enable = lib.mkEnableOption "Enable desktop support";
  };

  config = lib.mkIf cfg.enable {
    desktop.enable = true;

    programs = {
      hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      };

      hyprlock.enable = true;
    };

    services.hypridle.enable = true;

    security.polkit.enable = true;
  };
}
