{
  lib,
  config,
  ...
}: let
  cfg = config.hyprland.soriphoono;
in {
  config =
    lib.mkIf cfg.enable {
    };
}
