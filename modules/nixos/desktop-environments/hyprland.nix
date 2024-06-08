{ ... }: {
  programs = {
    regreet = { };

    hyprland.enable = true;
    hyprlock.enable = true;
  };

  services = {
    greetd = { };

    hypridle.enable = true;
  };
}
