{
  lib,
  config,
  ...
}: let
  cfg = config.core.shells.nushell;
in {
  options.core.shells.nushell.enable = lib.mkEnableOption "Enable nushell integration";

  config = lib.mkIf cfg.enable {
    programs.nushell = {
      enable = true;

      shellAliases = {
        v = "nvim";
      };
    };
  };
}
