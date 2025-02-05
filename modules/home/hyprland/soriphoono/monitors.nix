{
  lib,
  config,
  ...
}: let
  cfg = config.supporting.hyprland;
in {
  options.supporting.hyprland.monitors = lib.mkOption {
    type = let
      monitorType = lib.types.submodule {
        options = {
          name = lib.mkOption {
            type = lib.types.str;
            description = "The name of the monitor referenced";
          };

          resolution = lib.mkOption {
            type = lib.types.str;
            description = "The resolution of the monitor";
          };

          position = lib.mkOption {
            type = lib.types.str;
            description = "The position offset of the monitor in virtual space";
          };

          scale = lib.mkOption {
            type = lib.types.either lib.types.int lib.types.float;
            description = "The scale of the monitor";
          };
        };
      };
    in
      lib.types.listOf monitorType;
    description = "The monitors to reference";
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = {
      monitor = map (monitor: "${monitor.name}, ${monitor.resolution}, ${monitor.position}, ${toString monitor.scale}") cfg.monitors;
    };
  };
}
