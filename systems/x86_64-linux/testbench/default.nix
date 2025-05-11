{namespace, ...}: {
  imports = [
    ./disko.nix
  ];

  ${namespace}.core = {
    boot = {
      enable = true;
      primaryDevice = "/dev/vda";
    };
    secrets = {
      enable = true;
      defaultSopsFile = ./secrets.yaml;
    };
  };
}
