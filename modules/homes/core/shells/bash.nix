{ lib, config, ... }:
let cfg = config.core.shells.bash;
in {
  options = {
    core.shells.bash = {
      enable = lib.mkOption {
        type = with lib.types; bool;
        default = true;
        description = "Enable bash shell";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    core.shells.enable = lib.mkDefault true;

    programs.bash = {
      enable = true;
      enableCompletion = true;
      enableVteIntegration = true;
      historyControl = [ "ignoreboth" ];
    };
  };
}
