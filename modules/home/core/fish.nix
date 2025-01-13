{ lib, pkgs, nixosConfig, config, hostname, ... }:
let
  cfg = config.core.fish;
in
{
  options.core.fish = {
    enable = lib.mkOption {
      type = lib.types.bool;
      description = "Enable the fish shell";

      default = nixosConfig.programs.fish.enable;
    };
  };

  config = lib.mkIf cfg.enable {
    warnings =
      if !nixosConfig.programs.fish.enable
      then [
        "Fish is not installed at the system level, writing configs is not sufficient for a working install"
      ] else [ ];

    programs.fish = {
      enable = true;

      shellAliases = {
        g = "git";
        v = "nvim";

        rebuild =
          let
            rebuild_command = pkgs.writeShellApplication {
              name = "rebuild.sh";

              text = ''
                sudo nixos-rebuild switch --flake .#${hostname}

                nix-index
              '';
            };
          in
          "${rebuild_command}";
      };

      shellInitLast = ''
        set fish_greeting

        fastfetch
      '';
    };
  };
}
