{ lib, config, ... }: 
let cfg = config.programs;
in {
  options = {
    programs.enable = lib.mkEnableOption "Enable utilities programs in system scope";
  };

  config = lib.mkIf cfg.enable {
    
  };
}
