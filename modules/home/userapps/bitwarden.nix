{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.userapps.bitwarden;
in with lib; {
  options.userapps.bitwarden = {
    enable = mkEnableOption "Bitwarden password manager";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.bitwarden-desktop ];
  };
}
