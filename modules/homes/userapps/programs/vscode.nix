{ lib, pkgs, config, ... }:
let cfg = config.userapps.programs.vscode;
in {
  options = {
    userapps.programs.vscode.enable = lib.mkEnableOption "Enable vscode";
  };

  config = lib.mkIf cfg.enable {
    programs.vscode = {
      enable = true;

      package = pkgs.vscode-fhs;

      userSettings = {
        "window.titleBarStyle" = "custom";
        "window.dialogStyle" = "custom";
        "window.menuBarVisibility" = "compact";
        "workbench.colorTheme" = "Stylix";
        "workbench.iconTheme" = "catppuccin-mocha";
        "files.autoSave" = "onFocusChange";
        "editor.fontFamily" = "'JetBrainsMono Nerd Font Mono'";
        "editor.formatOnPaste" = true;
        "terminal.integrated.fontFamily" = "'JetBrainsMono Nerd Font Mono'";
        "git.autofetch" = true;
        "git.confirmSync" = true;
        "codeium.enableConfig" = {
          "*" = true;
          "nix" = true;
        };
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nixd";
        "nix.serverSettings" = {
          "nixd" = {
            "formatting" = {
              "command" = [
                "nixpkgs-fmt"
              ];
            };
          };
        };
      };
    };
  };
}
