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

  options.core.secrets.enable = lib.mkEnableOption "Enable secrets management";

  config = let
    secretsPath = ../../../secrets;
  in
    lib.mkIf cfg.enable {
      sops = {
        age = {
          keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
          sshKeyPaths = [];
          generateKey = true;
        };

        defaultSopsFile = "${secretsPath}/${config.home.username}.yaml";

        secrets.environment = {
          format = "dotenv";
          sopsFile = let
            environmentPath = "${secretsPath}/${config.home.username}.env";
          in
            lib.mkIf (builtins.pathExists environmentPath) environmentPath;
        };
      };
    };
}
