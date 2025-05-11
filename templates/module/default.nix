{
  inputs,
  lib,
  pkgs,
  config,
  namespace,
  ...
}: let
  path = "${namespace}.Your path here";
  cfg = config.${path};
in {
  options.${path} = {
    enable = lib.mkEnableOption "Enable ${path} module";
  };

  config = lib.mkIf cfg.enable {
    warnings = [
      "TODO: ${path} module"
    ];
  };
}
