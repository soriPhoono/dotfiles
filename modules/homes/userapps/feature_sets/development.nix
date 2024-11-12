{ lib, config, ... }:
let
  cfg = config.userapps.feature_sets;
in
{
  options = { userapps.feature_sets.development = lib.mkEnableOption "Enable office programs"; };

  config = lib.mkIf cfg.development {
    userapps.programs.vscode.enable = true;
  };
}
