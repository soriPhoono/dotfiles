{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.programs.sddm;
in {
  options.desktop.programs.sddm.enable = lib.mkEnableOption "Enable sddm greeter";

  config = lib.mkIf cfg.enable {
    services.displayManager.sddm = {
      enable = true;

      wayland.enable = true;
    };
  };
}
