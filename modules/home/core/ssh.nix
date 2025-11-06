{
  lib,
  config,
  ...
}:
with lib; {
  options.core.ssh = {
    publicKey = lib.mkOption {
      type = lib.types.str;
      description = "Public SSH key to use for authentication";
    };

    extraSSHKeys = mkOption {
      type = let
        gitIdentity = submodule {
          options = {
          };
        };
      in
        with types;
          attrsOf (oneOf [
            gitIdentity
            str
          ]);
      description = ''
        An attrset of path on disk/secret in vault containing
        the private key for this ssh key, will also be appended
        with .pub for public key
      '';
      default = {};
      example = {
      };
    };
  };

  config = {
    home.file.".ssh/id_ed25519.pub".text = config.core.ssh.publicKey;

    sops.secrets.ssh_key.path = "${config.home.homeDirectory}/.ssh/id_ed25519";

    programs.ssh.enable = true;
  };
}
