{ ... }: {
  programs = {
    regreet.enable = true;

    hyprland.enable = true;
    hyprlock.enable = true;
  };

  services = {
    greetd.enable = true;

    hypridle.enable = true;
  };
}
