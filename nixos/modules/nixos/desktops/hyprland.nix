{ pkgs, ... }: {
  programs = {
    dconf.enable = true;

    hyprland.enable = true;

    gamescope = {
      enable = true;
      capSysNice = true;

      # --rt -r <desired_framerate> --immediate-flips if stuttering
      # --force-grab-cursor if cursor is not grabbed
      args = [
        "-W 1920"
        "-H 1080"
        "-r 144"
        "-fbe"
      ];

      env = {

      };
    };
  };

  services.gnome.gnome-keyring.enable = true;

  security.polkit.enable = true;

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
}
