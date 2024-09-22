{
  programs.waybar = {
    enable = true;

    settings = {
      topBar = {
        layer = "top";
        position = "top";

        margin-top = 20;
        margin-left = 20;
        margin-right = 20;
        margin-bottom = 0;
        
        modules-left = [
          "custom/power"
          "hyprland/workspaces"
        ];

        modules-center = [
          
        ];

        modules-right = [
          
        ];

        "custom/power" = {
          format = "󱄅";
          on-click = "wlogout";
          tooltip-format = "Session controls";
        };

        "hyprland/workspaces" = {
          all-outputs = true;
          persistent-workspaces = {
            "*" = 6;
          };
          
          format-icons = {
            default = "";
            active = "";
          };

          format = "{icon}";
        };
      };
      bottomBar = {
        layer = "top";
        position = "bottom";
        mode = "overlay";
        start_hidden = true;
        fixed-center = true;

        modules-left = [
          
        ];

        modules-center = [
          
        ];

        modules-right = [
          
        ];
      };
    };
  };
}
