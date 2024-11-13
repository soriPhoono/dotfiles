{ lib, config, ... }:
let cfg = config.core.programs.ripgrep;
in {
  options = {
    core.programs.ripgrep.enable = lib.mkEnableOption "Enable ripgrep";
  };

  config = lib.mkIf cfg.enable {
    home.shellAliases.grep = "rg";

    programs.ripgrep.enable = true;
  };
}
