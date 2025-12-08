{
  lib,
  config,
  ...
}:
with lib; {
  options.core.ssh = {
    publicKey = lib.mkOption {
      type = with lib.types; nullOr str;
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
        "school" = "ssh-ed25519 AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
      };
    };
  };

  config = {
    home.file =
      {
        ".ssh/id_ed25519.pub".text = config.core.ssh.publicKey;
      }
      // (lib.mapAttrs (name: contents: {
          target = ".ssh/${name}.pub";
          text = contents;
        })
        config.core.ssh.extraSSHKeys);

    sops.secrets =
      lib.mkIf config.core.secrets.enable
      ({
          "ssh/primary_key".path = "${config.home.homeDirectory}/.ssh/id_ed25519";
        }
        // (lib.genAttrs (map (name: "ssh/${name}_key") (builtins.attrNames config.core.ssh.extraSSHKeys)) (secret: {
          path = "${config.home.homeDirectory}/.ssh/${builtins.replaceStrings ["ssh/"] [""] secret}";
        })));

    programs.ssh.enable = true;
  };
}
