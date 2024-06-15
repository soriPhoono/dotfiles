{ pkgs, ... }: {
  home.packages = with pkgs; [
    spotdl

    discord
    betterdiscordctl
  ];

  programs = {
    yt-dlp.enable = true;
  };

  # TODO: Setup torrent client
}
