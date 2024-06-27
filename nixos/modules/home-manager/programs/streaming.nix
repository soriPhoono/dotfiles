{ pkgs, ... }: {
  home.packages = with pkgs; [
    gimp
    obs-studio
    audacity
    davinci-resolve
  ];
}
