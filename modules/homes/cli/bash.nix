{ lib, config, ... }:
let cfg = config.cli.bash;
in {
  options = {
    cli.bash = {
      enable = lib.mkEnableOption "Bash customizations";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.bash = {
      enable = true;
      historyControl = [ "erasedups" "ignoreboth" ];
    };
  };
}
