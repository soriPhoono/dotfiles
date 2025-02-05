{
  lib,
  config,
  ...
}: let
  cfg = config.supporting.hyprland;
in {
  config =
    lib.mkIf cfg.enable {
    };
}
