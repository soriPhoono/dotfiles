{namespace, ...}: {
  imports = [
    ./disko.nix
  ];

  ${namespace}.core = {
    boot.enable = true;
    secrets = {
      enable = true;
      defaultSopsFile = ./secrets.yaml;
    };
  };
}
