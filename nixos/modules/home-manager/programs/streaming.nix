{ ... }: {
  home.packages = with pkgs; [
    obs-studio
    audacity
    davinci-resolve
  ];
}
