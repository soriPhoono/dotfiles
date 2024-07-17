{ lib, pkgs, config, ... }:
let cfg = config.core.cli;
in {
  options = {
    core.cli.enable = lib.mkEnableOption "Core CLI";
  };

  config = lib.mkIf cfg.enable {
    users.defaultUserShell = pkgs.fish;

    programs.fish.enable = true;
    programs.dconf.enable = true;
  };
}
