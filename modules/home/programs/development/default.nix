{ lib, config, ... }:
let cfg = config.programs.development;
in {
  options = {
    programs.
  };

  config = lib.mkIf cfg.enable {
    hardware.keyboard.qmk.enable = true;

    home.packages = with pkgs; [

    ];
  };
}
