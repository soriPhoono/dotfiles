{
  inputs,
  lib,
  pkgs,
  config,
  namespace,
  ...
}: let
  cfg = config.${namespace}.core;
in {
  options.${namespace}.core = {
    authorized = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Whether the target system can use secrets or is an initial install.
      '';
      example = true;
    };

    defaultSopsFile = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = ''
        The default secrets file to use for the secrets module.
        This is used when no specific secrets file is provided.
      '';
      example = ./secrets.nix;
    };
  };

  config = {
    services.openssh.enable = true;

    sops = {
      inherit (cfg) defaultSopsFile;
      age = {
        sshKeyPaths = map (key: key.path) config.services.openssh.hostKeys;
      };
    };
  };
}
