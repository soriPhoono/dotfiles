{ lib, config, ... }:
let cfg = config.core.programs.direnv;
in {
  options = {
    core.programs.direnv = {
      enable = lib.mkEnableOption
        "Enable direnv based declarative environment support";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.direnv = {
      enable = true;

      nix-direnv.enable = true;
    };

    core.shells.fish.extraShellInit = "direnv hook fish | source";
  };
}
