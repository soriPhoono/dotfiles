{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.gnome.dconf;
in {
  options.gnome.dconf.enable = lib.mkEnableOption "Enable dconf for gnome desktop";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      adw-gtk3
    ];

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = lib.mkForce "prefer-dark";
        gtk-theme = lib.mkForce "adw-gtk3-dark";
      };

      "org/gnome/shell/extensions/dash-to-dock" = {
        apply-custom-theme = true;
        background-opacity = 0.8;
        custom-theme-shrink = true;
        dash-max-icon-size = 48;
        dock-position = "BOTTOM";
        extend-height = false;
        height-fraction = 0.9;
        hotkeys-overlay = false;
        intellihide-mode = "ALL_WINDOWS";
        isolate-locations = true;
        middle-click-action = "launch";
        preferred-monitor = -2;
        preferred-monitor-by-connector = "DP-3";
        shift-click-action = "minimize";
        shift-middle-click-action = "launch";
        show-mounts = false;
      };
    };
  };
}
