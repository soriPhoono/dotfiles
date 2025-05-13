{
  imports = [
    ./disko.nix
  ];

  core = {
    boot.enable = true;

    secrets = {
      enable = true;
      defaultSopsFile = ./secrets.yaml;
    };

    networking = {
      enable = true;
      network-manager.enable = true;
      tailscale.enable = true;
    };
  };

  themes.catppuccin.enable = true;
}
