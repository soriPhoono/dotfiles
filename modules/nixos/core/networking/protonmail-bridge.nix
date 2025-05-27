{
  lib,
  config,
  ...
}: let
  cfg = config.core.networking.protonmail-bridge;
in {
  options.core.networking.protonmail-bridge.enable = lib.mkEnableOption "Enable protonmail-bridge";

  config = lib.mkIf cfg.enable {
    services.protonmail-bridge.enable = true;
  };
}
