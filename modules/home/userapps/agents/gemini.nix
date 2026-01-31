{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.userapps.agents.gemini;
in
  with lib; {
    options.userapps.agents.gemini = {
      enable = mkEnableOption "Enable Gemini AI agent";

      overrideEditor = mkOption {
        type = types.bool;
        default = true;
        description = "Override the default editor (VSCode) with Antigravity.";
      };

      skills = mkOption {
        type = with types; attrsOf (either str path);
        default = {};
        description = "Skill definitions for the Gemini agent. Can be raw strings or file paths.";
      };
    };

    config = mkMerge [
      (mkIf cfg.enable {
        home.packages = [
          pkgs.gemini-cli
        ];

        home.file =
          mapAttrs' (name: value: {
            name = ".config/gemini-chat/skills/${name}";
            value =
              if isPath value || isStorePath value
              then {source = value;}
              else {text = value;};
          })
          cfg.skills;
      })
      (mkIf (cfg.enable && cfg.overrideEditor) {
        userapps.development.editors.vscode = {
          package = mkDefault pkgs.antigravity;
        };
      })
    ];
  }
