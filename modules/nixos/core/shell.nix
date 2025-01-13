{ lib, pkgs, config, hostname, ... }:
let
  cfg = config.core.shell;
in
{
  options.core.shell = {
    shell = lib.mkOption {
      type = lib.types.enum [ "bash" "fish" ];
      description = "The package to use as the default user shell";

      default = "fish";
    };
  };

  config = {
    users.defaultUserShell =
      if cfg.shell == "fish" then pkgs.fish
      else pkgs.bashInteractive;

    programs.fish = {
      enable = cfg.shell == "fish";

      shellAliases = {
        rebuild =
          let
            rebuild_script = pkgs.writeShellApplication {
              name = "rebuild.sh";

              text = ''
                echo "[INFO] Re-creating system configuration, would you like to power down between generations, or roll over to the next in this power cycle? [s/r]"
                read -p ">>> " -n 1
                token = $(echo "$REPLY" | tr '[:upper:]' '[:lower:]')
                case "$token" in
                  s) sudo nixos-rebuild switch --flake github:soriphoono/dotfiles#${hostname};;
                  r) sudo nixos-rebuild boot --flake github:soriphoono/dotfiles#${hostname};;
                  *) echo "Bad entry, please try again..." && exit 1;;
                esac

                ${pkgs.nix-index}/bin/nix-index
              '';
            };
          in
          "${rebuild_script}";
      };
    };
  };
}
