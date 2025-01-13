{ lib, pkgs, config, ... }:
let
  this = "user.module";

  cfg = config."${this}";
in
{
  options."${this}" = {
    enable = lib.mkEnableOption "Enable this module";
  };

  config = lib.mkIf cfg.enable {
    warnings = [ ];

    # Your code goes here
  };
}
