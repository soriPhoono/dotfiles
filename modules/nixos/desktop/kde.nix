{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.kde;
in {
  options.desktop.kde.enable = lib.mkEnableOption "Enable KDE desktop environment";

  config = lib.mkIf cfg {
    # TODO: make this a module
    services.displayManager.sddm = {
      enable = true;

      wayland.enable = true;
    };

    services.desktopManager.plasma6.enable = true;

    stylix.targets.qt.platform = "qtct";
  };
}
