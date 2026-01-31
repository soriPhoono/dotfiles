{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.userapps.development.editors.vscode;
  hasGemini = config.userapps.agents ? gemini && config.userapps.agents.gemini.enable;
  shouldOverride = hasGemini && config.userapps.agents.gemini.overrideEditor;
in
  with lib; {
    options.userapps.development.editors.vscode = {
      enable = mkEnableOption "Enable vscode text editor";

      priority = mkOption {
        type = types.int;
        default = 30; # Lower priority than terminal editors by default
        description = "Priority for being the default editor. Lower is higher priority.";
      };
    };

    config = mkIf cfg.enable {
      home.sessionVariables = {
        EDITOR = mkOverride cfg.priority (
          if shouldOverride
          then "antigravity"
          else "code"
        );
        VISUAL = mkOverride cfg.priority (
          if shouldOverride
          then "antigravity"
          else "code"
        );
      };

      xdg.mimeApps.defaultApplications = let
        editor =
          if shouldOverride
          then ["antigravity.desktop"]
          else ["code.desktop"];
      in
        mkOverride cfg.priority {
          "text/plain" = editor;
          "text/markdown" = editor;
          "application/x-shellscript" = editor;
        };

      programs.vscode = {
        enable = true;
        package =
          if shouldOverride
          then pkgs.antigravity
          else pkgs.vscode;
      };
    };
  }
