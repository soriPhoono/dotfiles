{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.userapps.programs.thunderbird;
in {
  options.userapps.programs.thunderbird.enable = lib.mkEnableOption "Enable thunderbird mail client";

  config = lib.mkIf cfg.enable {
    programs.thunderbird = {
      enable = true;

      profiles.default.isDefault = true;
    };

    systemd.user.services.protonmail-bridge = {
      Unit = {
        Description = "Protonmail Bridge";
      };

      Service = {
        ExecStart = "${pkgs.protonmail-bridge}/bin/protonmail-bridge --noninteractive --log-level info";
      };

      Install = {
        WantedBy = [
          "graphical-session.target"
        ];
        PartOf = [
          "graphical-session.target"
        ];
      };
    };
  };
}
