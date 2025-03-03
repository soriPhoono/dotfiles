{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.userapps.programs.firefox;
in {
  options.userapps.programs.firefox.enable = lib.mkEnableOption "Enable Firefox";

  config = lib.mkIf cfg.enable {
    programs.librewolf = {
      enable = true;

      policies = {
        DisableTelementry = true;
        DisplayBookmarksToolbar = "never";
      };
    };

    wayland.windowManager.hyprland.settings.bind = [
      "$mod, B, exec, ${pkgs.librewolf}/bin/librewolf"
    ];

    services = {
      psd = {
        enable = true;
        resyncTimer = "10m";
      };
    };
  };
}
