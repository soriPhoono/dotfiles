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
      type = with types; attrsOf str;
      description = ''
        An attrset of path on disk/secret in vault containing
        the private key for this ssh key, will also be appended
        with .pub for public key
      '';
      default = {};
      example = {
        "school_key" = "ssh-ed25519 AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
      };
    };
  };

  config = {
    home.file = {
      ".ssh/id_ed25519.pub".text = config.core.ssh.publicKey;
    } // (lib.mapAttrs (name: contents: {
      target = ".ssh/${name}.pub";
      text = contents;
    }) config.core.ssh.extraSSHKeys);

    sops.secrets = {
      "ssh/primary_key".path = "${config.home.homeDirectory}/.ssh/id_ed25519";
    } // (lib.mapAttrs (name: path: {
      path = "${config.home.homeDirectory}/.ssh/${name}";
    }) config.core.ssh.extraSSHKeys);

    programs.ssh.enable = true;
  };
}
