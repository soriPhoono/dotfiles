{ config, pkgs, ... }: {
  services.greetd = {
    enable = true;

    vt = 1;

    settings.default_session
      .user = "greeter";
  };
}
