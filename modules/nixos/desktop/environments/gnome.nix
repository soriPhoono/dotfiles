{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.desktop.environments.gnome;
in {
  options.desktop.environments.gnome = {
    enable = lib.mkEnableOption "Enable gnome desktop environment";
  };

  config = lib.mkIf cfg.enable {
    desktop.enable = true;

    environment = {
      sessionVariables = {
        NIXOS_OZONE_WL = "1";
        GST_PLUGIN_SYSTEM_PATH_1_0 = with pkgs.gst_all_1; lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0" [
          gst-plugins-good
          gst-plugins-bad
          gst-plugins-ugly
          gst-libav
        ];
      };

      systemPackages = with pkgs.gnomeExtensions; [
        dash-to-dock
        removable-drive-menu
      ];
    };

    services = {
      displayManager = {
        defaultSession = lib.mkDefault "gnome";
        gdm = {
          enable = true;
          wayland = true;
        };
      };
      desktopManager.gnome.enable = true;
    };
  };
}
