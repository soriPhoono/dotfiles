{ pkgs, ... }: {
  home.packages = with pkgs; [
    discord
    betterdiscordctl

    spotdl

    google-chrome
  ];

  programs = { yt-dlp.enable = true; };

  # TODO: Setup torrent client
}
