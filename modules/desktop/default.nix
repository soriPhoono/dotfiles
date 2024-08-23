{ lib
, pkgs
, config
, ...
}:
let cfg = config.desktop.enable;
in  {
  options = {
    desktop.enable = lib.mkEnableOption "Enable desktop support";
  };

  config = lib.mkIf cfg.enable {
    
  };
}
