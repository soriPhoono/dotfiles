{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.userapps.office.nextcloud;
in {
  options.userapps.office.nextcloud = {
    enable = lib.mkEnableOption "nextcloud client";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      nextcloud-client
    ];
  };
}
