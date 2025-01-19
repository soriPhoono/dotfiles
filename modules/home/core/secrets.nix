{
  inputs,
  lib,
  config,
  ...
}: let
  cfg = config.core.secrets;
in {
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  options.core.secrets = {
    enable = lib.mkEnableOption "Enable secrets management";
  };

  config = lib.mkIf cfg.enable {
    sops = {
      age.sshKeyPaths = [];

      gnupg = {
        home = "~/.gnupg";
        sshKeyPaths = [];
      };

      defaultSopsFile = ../../../secrets/${config.core.username}/user.yaml;
    };
  };
}
