{
  lib,
  config,
  ...
}: let
  cfg = config.userapps.discord;
in {
  options.userapps.discord.enable = lib.mkEnableOption "Enable discord desktop client with mods";

  config = lib.mkIf cfg.enable {
    programs.vesktop.enable = true;
  };
}
