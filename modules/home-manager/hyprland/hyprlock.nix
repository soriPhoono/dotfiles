{ ... }: {
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        hide_cursor = true;
        grace = 5;
        ignore_empty_input = true;
      };

      background = [
        {
          monitor = "eDP-1";
          path = "${../../../assets/wallpapers/1.png}";

          blur_passes = 1;
          blur_size = 3;
          noise = 0.0117;
          contrast = 0.8916;
          brightness = 0.8172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        }
      ];

      label = [
        {
          monitor = "eDP-1";
          text = "$TIME";
          text_align = "center";
          rotate = 0;

          position = "20, 20";
          halign = "right";
          valign = "bottom";
        }
        {
          monitor = "eDP-1";
          text = "Welcome $DESC, please enter your password";
          text_align = "center";
          rotate = 0;

          position = "0, 0";
          halign = "center";
          valign = "center";
        }
      ];

      input-field = [
        {
          monitor = "eDP-1";
          size = "200, 50";
          outline_thickness = 3;
          fade_on_empty = true;
          placeholder_text = "$PROMPT";
          hide_input = true;
          rounding = 3;

          position = "0, -75";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}