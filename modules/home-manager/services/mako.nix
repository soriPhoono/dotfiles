{ ... }: {
  services.mako = {
    enable = true;
    anchor = "bottom-right";

    defaultTimeout = 5000;
    borderSize = 3;
    borderRadius = 7;
  };
}