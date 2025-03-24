{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.services.gdm;
in {
  options.desktop.services.gdm.enable = lib.mkEnableOption "Enable sddm greeter";

  config = lib.mkIf cfg.enable {
    services.xserver.displayManager.gdm = {
      enable = true;
    };
  };
}
