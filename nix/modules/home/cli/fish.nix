{ lib, pkgs, config, ... }:
let cfg = config.cli.fish;
in {
  options = {
    cli.fish = {
      enable = lib.mkEnableOption "Enable fish shell";

      extraShellInit = lib.mkOption {
        type = lib.types.lines;
        description = "Extra arguments to add to shellInit script";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    programs.fish = {
      enable = true;

      shellAliases = with pkgs; {
        cat = "${bat}/bin/bat";
        df = "${duf}/bin/duf";
        du = "${dua}/bin/dua i";
        find = "${fd}/bin/fd";
        search = "${fzf}/bin/fzf";
        grep = "${ripgrep}/bin/rg";
      };

      shellInitLast = ''
        set fish_greeting

        ${cfg.extraShellInit}
      '';
    };
  };
}
