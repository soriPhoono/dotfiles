{ ... }: {
  programs = {
    steam = {
      enable = true;

      extest.enable = true;
    };

    gamemode = {
      enable = true;

      enableRenice = true;
    };

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
}
