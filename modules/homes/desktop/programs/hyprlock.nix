{ lib, config, ... }:
let cfg = config.desktop.programs.hyprlock;
in {
  options = {
    desktop.programs.hyprlock.enable =
      lib.mkEnableOption "Enable hyprlock screen locking system";
  };

  config = lib.mkIf cfg.enable {
    programs.hyprlock = {
      enable = true;

      settings = {
        general = {
          disable_loading_bar = true;
          hide_cursor = true;
          grace = 5;
          ignore_empty_input = true;
        };

        background = [{
          path = "screenshot";
          blur_passes = 3;
          blur_size = 8;
        }];
      };
    };
  };
}
