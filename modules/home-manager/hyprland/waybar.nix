{ ... }: {
  programs.waybar = {
    enable = true;

    settings = {
      hud = {
        output = [
          "eDP-1"
        ];

        layer = "top";
        position = "top";
        height = 30;
        margin-top = 20;
        margin-left = 20;
        margin-right = 20;

        modules-left = [
          "hyprland/window"
        ];

        modules-center = [
          "hyprland/workspaces"
        ];

        modules-right = [
          "network"
          "bluetooth"
          "wireplumber"
          "battery"
          "clock"
        ];
      };
    };

/*     style = ''

    ''; */
  };
}
