{
  lib,
  config,
  ...
}: let cfg = config.themes.default;
in with lib; {
  options.themes.default = {
    enable = mkEnableOption "Enable default theme customizations for terminal";
  };

  config = mkIf cfg.enable {
    stylix = {
      enable = true;

      image = ../../../assets/wallpapers/beach-path.jpg;
    };
  };
}
