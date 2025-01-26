{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.core.shell;
in {
  options.core.shell = {
    shell = lib.mkOption {
      type = lib.types.enum ["bash" "fish"];
      description = "The package to use as the default user shell";

      default = "fish";
    };
  };

  config = {
    users.defaultUserShell =
      if cfg.shell == "fish"
      then pkgs.fish
      else pkgs.bashInteractive;

    programs = {
      dconf.enable = true;

      fish = {
        enable = cfg.shell == "fish";

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
