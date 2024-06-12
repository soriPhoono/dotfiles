{ pkgs, ... }: {
  home.packages = with pkgs; [
    spotdl

    discord
    betterdiscordctl
  ];

  programs.yt-dlp.enable = true;
}
