{ pkgs, pkgs-stable, ... }: {
  home.packages = (with pkgs; [
    discord
    betterdiscordctl

    google-chrome
  ]) ++ (with pkgs-stable; [
    spotdl
  ]);

  programs = {
    yt-dlp.enable = true;
  };

  # TODO: Setup torrent client
}
