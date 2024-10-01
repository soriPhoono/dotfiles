{ lib, pkgs, config, ... }:
let cfg = config.desktop.programs.docker;
in {
  options = {
    desktop.programs.docker.enable =
      lib.mkEnableOption "Enable docker container manager";
  };

  config = lib.mkIf cfg.enable {

  };
}
