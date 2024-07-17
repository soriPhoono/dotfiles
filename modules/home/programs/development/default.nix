{ lib, pkgs, config, ... }:
let cfg = config.programs.development;
in {
  options = {
    programs.
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [

    ];
  };
}
