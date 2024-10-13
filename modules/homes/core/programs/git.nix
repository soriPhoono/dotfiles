{ lib, config, ... }:
let cfg = config.core.programs.git;
in {
  options = {
    core.programs.git = {
      enable = lib.mkEnableOption "Enable git support";

      userName = lib.mkOption {
        type = with lib.types; str;
        description = "Git user name";
      };

      userEmail = lib.mkOption {
        type = with lib.types; str;
        description = "Git user email";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      inherit (cfg) userName userEmail;

      enable = true;

      extraConfig = {
        init.defaultBranch = "main";
        url."git@github.com:" = { insteadOf = [ "gh:" "github:" ]; };
        pull.rebase = false;
      };

      delta = {
        enable = true;

        options = {
          dark = true;
          line-numbers = true;
          side-by-side = true;

          diff.colorMoved = "default";
          merge.conflictstyle = "diff3";
        };
      };
    };
  };
}
