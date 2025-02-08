{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.noir;
in {
  config = lib.mkIf cfg.enable {
    stylix.targets.hyprlock.enable = false;

    programs.hyprlock = {
      enable = true;
      settings = {
        general = {
          disable_loading_bar = true;
          hide_cursor = true;
          grace = 5;
          ignore_empty_input = true;
        };

        background = [
          {
            path = "screenshot";
            blur_passes = 3;
            blur_size = 8;
          }
        ];

        input-field = [
          {
            size = "200, 50";
            position = "0, -80";
            monitor = (lib.elemAt (lib.filter (monitor: monitor.default) cfg.monitors) 0).name;
            dots_center = true;
            fade_on_empty = true;
            font_color = "rgb(202, 211, 245)";
            inner_color = "rgb(91, 96, 120)";
            outer_color = "rgb(24, 25, 38)";
            outline_thickness = 3;
            placeholder_text = "<span foreground='#cad3f5'>Password...</span>";
            shadow_passes = 2;
          }
        ];
      };
    };
  };
}
