{ lib, config, ... }:
let cfg = config.core.shells.bash;
in {
  options = {
    core.shells.bash = {
      enable = lib.mkOption {
        type = with lib.types; boo;
        default = true;
        description =  "Enable bash shell";
      };

      extraShellInit = lib.mkOption {
        type = with lib.types; lines;
        description = "Extra arguments to add to shellInit script";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    core.shells.enable = lib.mkDefault true;

    programs.bash = {
      enable = true;
      enableCompletion = true;
      enableVteIntegration = true;
      historyControl = "ignoreboth";

      initExtra = cfg.extraShellInit;
    };
  };
}
