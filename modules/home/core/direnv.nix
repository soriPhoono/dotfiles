{
  lib,
  config,
  ...
}: let
  cfg = config.core.direnv;
in {
  options.core.direnv = {
    enable = lib.mkEnableOption "Enable direnv";
  };

  config = lib.mkIf cfg.enable {
    programs.direnv = {
      enable = true;

      nix-direnv.enable = true;
    };
  };
}
