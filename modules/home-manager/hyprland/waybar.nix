{ ... }: {
  programs.waybar = {
    enable = true;

    settings = {
      output = [
        "eDP-1"
      ];

      name = "hud";
      layer = "top";
      position = "top";
      height = 30;
      margin-top = 20;
      margin-left = 20;
      margin-right = 20;

      modules-left = [

      ];

      modules-center = [

      ];

      modules-right = [

      ];
    };
  };
}
