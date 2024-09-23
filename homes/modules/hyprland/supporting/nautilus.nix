{
  programs.nautilus-open-any-terminal = {
    enable = true;
    terminal = "alacritty";
  };

  services = {
    gnome.sushi.enable = true;

    gvfs.enable = true;
  };
}
