{ lib, pkgs, config, ... }:
let cfg = config.desktop.services.polkit_gnome;
in {
  options = {
    desktop.services.polkit_gnome = {
      enable = lib.mkEnableOption "Enable polkit_gnome";
    };
  };

  config = lib.mkIf cfg.enable {
    systemd = {
      user.services.polkit-gnome-authentication-agent-1 = {
        description = "polkit-gnome-authentication-agent-1";
        wantedBy = [ "graphical-session.target" ];
        wants = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
      };
    };
  };
} 
