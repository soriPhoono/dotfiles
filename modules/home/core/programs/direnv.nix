{
  lib,
  config,
  ...
}: let
  cfg = config.core.programs.direnv;
in {
  options.core.programs.direnv = {
    enable = lib.mkEnableOption "Enable direnv";
  };

  config = lib.mkIf cfg.enable {
    programs.direnv = {
      enable = true;

      nix-direnv.enable = true;
    };
  };
}
