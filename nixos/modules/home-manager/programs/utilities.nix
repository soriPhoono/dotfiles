{ pkgs, ... }: {
  home.packages = with pkgs; [
    spotdl

    discord
    betterdiscordctl

    google-chrome
  ];

  programs = {
    yt-dlp.enable = true;
  };

  # TODO: Setup torrent client
}
