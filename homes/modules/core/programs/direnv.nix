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
    direnv = {
      enable = true;

      nix-direnv.enable = true;
    };

    config.core.shells.fish.extraShellInit =
      lib.mkIf config.core.shells.fish.enable "direnv hook fish | source";
  };
}
