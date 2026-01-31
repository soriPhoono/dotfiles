{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.userapps.agents.claude;
in
  with lib; {
    options.userapps.agents.claude = {
      enable = mkEnableOption "Enable Claude AI agent";

      skills = mkOption {
        type = with types; attrsOf (either str path);
        default = {};
        description = "Skill definitions for the Claude agent. Can be raw strings or file paths.";
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [
        # Placeholder for claude cli or tools
      ];

      home.file =
        mapAttrs' (name: value: {
          name = ".config/claude-code/skills/${name}";
          value =
            if isPath value || isStorePath value
            then {source = value;}
            else {text = value;};
        })
        cfg.skills;
    };
  }
