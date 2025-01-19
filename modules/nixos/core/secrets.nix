{
  inputs,
  lib,
  config,
  ...
}: let
  cfg = config.core.secrets;
in {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  networking.hostName = config.core.hostname;

  programs.gnupg.agent.enable = true;

  services.openssh = {
    enable = true;

    hostKeys = [
      {
        comment = "ed25519 system key for host: ${config.core.hostname}";

        path = "/etc/ssh/ssh_host_ed25519_key";
        rounds = 100;
        type = "ed25519";
      }
    ];
  };
}
