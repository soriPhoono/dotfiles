{ ... }: {
  services = {
    mpd = {
      enable = true;

      network.startWhenNeeded = true;
    };

    mpd-mpris = {
      enable = true;
      mpd.useLocal = true;
    };

    mpd-discord-rpc = {
      enable = true;

      settings = {
        hosts = [ "localhost:6600" ];
        format = {
          details = "$title";
          state = "On $album by $artist";
        };
      };
    };
  };
}
