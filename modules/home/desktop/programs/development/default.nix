{ lib
, pkgs
, config
, ...
}:
let
  cfg = config.desktop.programs.development;
in
{
  options = {
    desktop.programs.development = {
      enable = lib.mkEnableOption "Enable development suite of gui applications";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode;

      enableUpdateCheck = true;
      enableExtensionUpdateCheck = true;

      extensions = with pkgs.vscode-extensions; [
        catppuccin.catppuccin-vsc-icons

        jnoortheen.nix-ide
      ];

      userSettings = {
        "window.titleBarStyle" = "custom";

        "workbench.colorTheme" = "Stylix";
        "workbench.iconTheme" = "catppuccin-mocha";

        "files.autoSave" = "onFocusChange";

        "editor.fontFamily" = "'JetBrainsMono Nerd Font Mono'";
        "editor.formatOnSave" = true;
        "editor.formatOnPaste" = true;

        "terminal.integrated.fontFamily" = "'JetBrainsMono Nerd Font Mono'";

        "git.autofetch" = true;
        "git.confirmSync" = false;

        "nix.serverSettings" = {
          "nixd" = {
            "formatting" = {
              "command" = "nixpkgs-fmt";
            };
          };
        };
      };
    };
  };
}
