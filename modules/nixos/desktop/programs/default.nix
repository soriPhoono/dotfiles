{ lib, config, ... }:
let cfg = config.desktop.programs;
in {
  options = {
    desktop.programs.enable = lib.mkEnableOption "Enable desktop programs";
  };

  config = {
    programs.corectrl.enable = true;
  };
}
