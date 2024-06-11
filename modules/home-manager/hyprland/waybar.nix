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
        height = 40;
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

        battery = {
          format = "{icon}";
          format-icons = ["󰁺" "󰁼" "󰁾" "󰂀" "󰂂" "󰁹"];
          tooltip-format = "{percentage}% ({timeTo})";

          stages = {
            full = 100;
            high = 90;
            medium = 70;
            low = 50;
            warning = 30;
            critical = 10;
          };
        };
      };
    };

    style = ''

    '';
  };
}
