{ lib, pkgs, config, ... }:
let cfg = config.desktop.programs.podman;
in {
  options = {
    desktop.programs.podman.enable =
      lib.mkEnableOption "Enable docker container manager";
  };

  config = lib.mkIf cfg.enable {

  };
}
