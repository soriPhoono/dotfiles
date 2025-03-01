{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.desktop.programs.regreet;
in {
  options.desktop.programs.regreet.enable = lib.mkEnableOption "Enable regreet system";

  config = lib.mkIf cfg.enable {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = let
            greetd_config = pkgs.writeTextFile {
              name = "hyprland.conf";
              text = ''
                exec-once = regreet; hyprctl dispatch exit
                misc = {
                  disable_hyprland_logo = true
                  disable_splash_rendering = true
                  disable_hyprland_qtutils_check = true
                }
              '';
            };
          in "${pkgs.hyprland}/bin/Hyprland --config ${greetd_config}/bin/hyprland.conf";
          user = "greeter";
        };
      };
    };

    programs.regreet = {
      enable = true;
    };
  };
}
