{
  lib,
  config,
  ...
}: let
  cfg = config.environments.hyprland.default;
in
  with lib; {
    config = mkIf cfg.enable {
      wayland.windowManager.hyprland.settings = {
        general = {
          border_size = 3;
          gaps_out = 10;

          no_focus_fallback = true;
          resize_on_border = true;
          resize_corner = 3;

          snap.enabled = true;
        };

        decoration = {
          rounding = 10;
        };
      };
    };
  }
