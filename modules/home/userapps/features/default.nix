{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.userapps.features;
in {
  imports = [
    ./artwork.nix
    ./streaming.nix
  ];

  options.userapps.features = {
    enable = lib.mkEnableOption "Enable core applications and default feature-set";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      # communications
      signal-desktop
      element-desktop

      # office
      onlyoffice-desktopeditors

      # tools
      gimp
    ];
  };
}
