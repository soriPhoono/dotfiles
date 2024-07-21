{ pkgs, ... }: {
  home.packages = with pkgs; [
    imagemagick

    yt-dlp
    spotdl
    ytmdl
  ];
}
