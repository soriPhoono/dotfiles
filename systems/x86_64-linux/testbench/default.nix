{namespace, ...}: {
  ${namespace}.core = {
    boot.enable = true;
    secrets = {
      enable = true;
      defaultSopsFile = ./secrets.yaml;
    };
  };
}
