{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.noir;
in {
  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = {
      general = {
        border_size = 3;

        snap = {
          enabled = true;
          border_overlap = true;
        };
      };

      decoration.rounding = 5;

      input = {
        repeat_rate = 20;
        repeat_delay = 300;

        accel_profile = "flat";
      };

      gestures = {
        workspace_swipe = true;
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;
      };

      xwayland.force_zero_scaling = true;

      cursor.no_hardware_cursors = true;
    };
  };
}
