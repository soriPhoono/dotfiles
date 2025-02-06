{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.noir;
in {
  config = lib.mkIf cfg.enable {
    programs.waybar = {
      enable = true;

      settings = {
        statusBar = {
          layer = "top";

          height = 20;

          margin-top = 20;
          margin-left = 20;
          margin-right = 20;

          modules-left = [
          ];

          modules-center = [
          ];

          modules-right = [
            "battery"
            "clock"
          ];

          "battery" = {
            "format" = "{capacity}% {icon}";
            "format-icons" = ["" "" "" "" ""];
          };
          "clock" = {
            "format-alt" = "{:%a, %d. %b  %H:%M}";
          };
        };
      };

      style = ''

      '';

      systemd.enable = true;
    };
  };
}
