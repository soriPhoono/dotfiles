{ config, pkgs, ... }: {
  services.greetd = {
    enable = true;

    vt = 1;

    settings = {
      default_session = {
        command = "Hyprland --config /etc/greetd/hyprland.conf";
        user = "greeter";
      };
    };
  };
}
