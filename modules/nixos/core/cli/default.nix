{ lib, config, ... }:
let cfg = config.core.cli;
in {
  options = {
    core.cli.enable = lib.mkEnableOption "Home CLI";
  };

  config = lib.mkIf cfg.enable {
    fish.enable = true;

    dconf.enable = true;
  }
}
