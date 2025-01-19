_: {
  core.hostname = "recovery";

  system = {
    boot = {
      enable = true;
      plymouth.enable = true;
    };
  };
}
