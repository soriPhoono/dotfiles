{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.userapps.office.bitwarden;
in
  with lib; {
    options.userapps.office.bitwarden = {
      enable = mkEnableOption "Bitwarden password manager";
    };

    config = mkIf cfg.enable {
      home.packages = [pkgs.bitwarden-desktop];
    };
  }
