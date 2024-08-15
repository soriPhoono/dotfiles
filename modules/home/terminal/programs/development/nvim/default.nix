{ lib, config, ... }:
let cfg = config.terminal.programs.development;
in {
  config = lib.mkIf cfg.enable {
    programs.nixvim.enable = true;
  };
}
