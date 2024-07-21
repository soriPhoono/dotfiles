{ lib, config, ... }:
let cfg = config.desktops.programs.util.hyprlock;
in {
  options = {
    desktops.programs.util.hyprlock.enable = lib.mkEnableOption "Enable hyprlock";
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
          text_trim = true;
        };

        background = [
          {
            path = "screenshot";

            blur_passes = 1;
            blur_size = 7;
            noise = 0.0117;
            contrast = 0.8916;
            brightness = 0.8172;
            vibrancy = 0.1696;
            vibrancy_darkness = 0.0;
          }
        ];

        label = [
          {
            text = "Hello, $USER!";
            text_align = "center";
            halign = "center";
            valign = "center";
          }
          {
            text = "$TIME";
            text_align = "center";
            halign = "right";
            valign = "bottom";
          }
        ];

        input-field = [
          {
            fade_on_empty = true;
            placeholder_text = "Input password...";
            hide_input = true;
            halign = "center";
            valign = "center";
          }
        ];
      };
    };
  };
}
