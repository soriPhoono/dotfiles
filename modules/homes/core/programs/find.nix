{ lib, pkgs, config, ... }:
let cfg = config.core.programs.find;
in {
  options = {
    core.programs.find = {
      enable = lib.mkEnableOption "Enable find file locator";
    };
  };

  config = lib.mkIf cfg.enable {
    home.shellAliases = with pkgs; { find = "${fzf}/bin/fzf"; };

    programs = {
      fd = {
        enable = true;
        hidden = true;

        extraOptions = [ "--follow" "--color=always" ];

        ignores = [ ".git" "*.bak" ];
      };

      fzf = {
        enable = true;
        enableFishIntegration = config.core.shells.fish.enable;

        defaultCommand = "fd --type file";
        defaultOptions = [ "--ansi" ];
      };
    };
  };
}
