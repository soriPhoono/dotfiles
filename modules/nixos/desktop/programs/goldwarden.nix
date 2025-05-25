{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.programs.goldwarden;
in {
  options.desktop.programs.goldwarden.enable = lib.mkEnableOption "Enable bitwarden desktop client";

  config = lib.mkIf cfg.enable {
    programs.goldwarden = {
      enable = true;
      useSshAgent = true;
    };
  };
}
