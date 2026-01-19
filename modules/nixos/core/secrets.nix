{
  lib,
  config,
  ...
}: let
  cfg = config.core.secrets;
in
  with lib; {
    options.core.secrets = {
      enable = lib.mkEnableOption "Enable the core secrets module";

      defaultSopsFile = lib.mkOption {
        type = lib.types.nullOr lib.types.path;
        default = null;
        description = ''
          The default secrets file to use for the secrets module.
          This is used when no specific secrets file is provided.
        '';
        example = ./secrets.yaml;
      };
    };

    config = lib.mkIf config.core.secrets.enable {
      systemd.tmpfiles.rules = lib.flatten (map (username:
        if config.home-manager.users.${username}.core.secrets.enable
        then [
          "d /home/${username}/.config/ 0755 ${username} users -"
          "d /home/${username}/.config/sops/ 0755 ${username} users -"
          "d /home/${username}/.config/sops/age/ 0755 ${username} users -"
        ]
        else []) (builtins.attrNames config.core.users));

      sops = {
        defaultSopsFile = lib.mkIf (cfg.defaultSopsFile != null) cfg.defaultSopsFile;

        age.sshKeyPaths = map (key: key.path) config.services.openssh.hostKeys;

        secrets =
          lib.genAttrs
          (filter (item: item != null) (map (name:
            if config.home-manager.users.${name}.core.secrets.enable
            then "users/${name}/age_key"
            else null) (builtins.attrNames config.core.users)))
          (name: let
            username = builtins.elemAt (lib.splitString "/" name) 1;
          in {
            path = "/home/${username}/.config/sops/age/keys.txt";
            mode = "0400";
            owner = username;
            group = "users";
          });
      };
    };
  }
