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
    programs.bash = {
      enable = true;
      historyControl = [ "ignoreboth" ];
    };
  };
}
