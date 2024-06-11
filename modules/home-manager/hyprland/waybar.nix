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
        margin-top = 15;
        margin-left = 15;
        margin-right = 15;

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

    style = ''

    '';
  };
}
