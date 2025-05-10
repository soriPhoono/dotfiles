{ inputs, lib, pkgs, config, namespace, ... }:
let cfg = config.${namespace}.core;
in {
  options.${namespace}.core.defaultSopsFile = lib.mkOption {
    type = lib.types.nullOr lib.types.path;
    default = null;
    description = ''
      The default secrets file to use for the secrets module.
      This is used when no specific secrets file is provided.
    '';
    example = ./secrets.nix;
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
