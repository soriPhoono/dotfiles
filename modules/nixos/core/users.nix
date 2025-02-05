{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.core.admin;
in {
  options.core.admin = {
    users = let
      userType = lib.types.submodule {
        options = {
          name = lib.mkOption {
            type = lib.types.str;
            description = "The user's unix name";
          };

          shell = lib.mkOption {
            type = lib.types.package;
            description = "The package to use as the user's shell";

            default = pkgs.fish;
          };
        };
      };
    in
      lib.mkOption {
        type = lib.types.listOf userType;
        description = "The users and shells to configure for interaction";

        default = [
          {
            name = "soriphoono";
          }
        ];
      };
  };

  config = {
    security.sudo.wheelNeedsPassword = false;

    sops.secrets = let
      sopsFile = ../../../secrets/global.yaml;

      getName = token: lib.elemAt (lib.splitString "/" token) 0;
    in
      lib.genAttrs
      (map (user: "${user.name}/password") cfg.users)
      (name: {
        inherit sopsFile;

        neededForUsers = true;
      })
      // lib.genAttrs
      (map (user: "${user.name}/age_key") cfg.users)
      (name: let
        username = getName name;
      in {
        inherit sopsFile;

        path = "/home/${username}/.config/sops/age/keys.txt";

        mode = "0440";
        owner = username;
        group = "users";
      });

    snowfallorg.users = lib.genAttrs cfg.users (name: {});

    users.users = lib.genAttrs cfg.users (user: {
      inherit (user) shell;

      hashedPasswordFile = config.sops.secrets."${user.name}/password".path;
    });

    programs = {
      dconf.enable = true;

      fish = {
        enable = builtins.any (user: user.shell == pkgs.fish) cfg.users;

        shellAliases.rebuild = let
          rebuild = pkgs.writeShellApplication {
            name = "rebuild.sh";

            text = ''
              select choice in switch boot cancel
              do
                case $choice
                in
                  switch)
                    sudo nixos-rebuild switch --flake '.#${config.core.hostname}'
                    break
                    ;;
                  boot)
                    sudo nixos-rebuild boot --flake '.#${config.core.hostname}'
                    break
                    ;;
                  cancel)
                    break
                    ;;
                  *)
                    echo "Bad selection"
                    ;;
                esac
              done

              nix-index
            '';
          };
        in "${rebuild}/bin/rebuild.sh";
      };
    };
  };
}
