{ lib, pkgs, config, ... }:
let
  cfg = config.core.shell;
in
{
  options.core.shell = {
    shell = lib.mkOption {
      type = with pkgs; lib.types.enum [ fish bash ];
      description = "The package to use as the default user shell";

      default = pkgs.fish;
    };
  };

  config = {
    users.defaultUserShell = cfg.shell;

    programs = {
      fish.enable = cfg.shell == pkgs.fish;
    };
  };
}
