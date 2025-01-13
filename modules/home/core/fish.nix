{ lib, pkgs, config, ... }:
let
  cfg = config.core.fish;
in
{
  options.core.fish.enable = lib.mkEnableOption "Enable the fish shell";

  config = lib.mkIf cfg.enable {
    programs.fish = {
      enable = true;

      shellAliases = {
        g = "${pkgs.git}/bin/git";
        v = "${pkgs.neovim}/bin/nvim";
      };

      shellInitLast =
        let
          shell_init = pkgs.writeShellApplication {
            name = "shell_init.sh";

            runtimeInputs = with pkgs; [
              fastfetch
            ];

            text = ''
              fastfetch
            '';
          };
        in
        ''
          set fish_greeting

          ${shell_init}/bin/shell_init.sh
        '';
    };
  };
}
