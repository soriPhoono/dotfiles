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

    programs = let
      rebuild_script = pkgs.writeShellApplication {
        name = "rebuild.sh";

        runtimeInputs = with pkgs; [
          nix-index
        ];

        # TODO: check this
        text = ''
          select choice in switch boot cancel
          do
            case $choice in
              switch)
                sudo nixos-rebuild switch --flake .#${config.networking.hostName}
                break
                ;;
              boot)
                sudo nixos-rebuild boot --flake .#${config.networking.hostName}
                break
                ;;
              cancel)
                exit 0
                ;;
              *)
                echo "Invalid selection"
                ;;
            esac
          done

          nix-index
        '';
      };
    in {
      dconf.enable = true;

      fish = {
        enable = cfg.shell == "fish";

        shellAliases = {
          rebuild = "${rebuild_script}/bin/rebuild.sh";
        };
      };
    };
  };
}
