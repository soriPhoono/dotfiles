{ ... }: {
  location.provider = "geoclue2";

  services.geoclue2.enable = true;

  services = {
    geoclue2.enable = true;

    localtimed.enable = true;
  };
}
