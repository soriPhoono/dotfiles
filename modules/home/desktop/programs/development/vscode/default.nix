{ lib
, pkgs
, config
, ...
}:
let
  cfg = config.desktop.programs.development.vscode;
in
{
  options = {
    desktop.programs.development.vscode = {
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

        github.copilot
        github.copilot-chat

        eamodio.gitlens

        jnoortheen.nix-ide

        vadimcn.vscode-lldb

        ziglang.vscode-zig

        rust-lang.rust-analyzer
        tamasfe.even-better-toml

        ms-python.python
        ms-python.debugpy
        ms-python.vscode-pylance
        ms-pyright.pyright
        ms-python.isort
        ms-python.black-formatter
      ];

      userSettings = {
        "window.titleBarStyle" = "custom";
        "window.dialogStyle" = "custom";
        "window.menuBarVisibility" = "compact";

        "workbench.colorTheme" = "Stylix";
        "workbench.iconTheme" = "catppuccin-mocha";

        "files.autoSave" = "onFocusChange";

        "editor.fontFamily" = "'JetBrainsMono Nerd Font Mono'";
        "editor.formatOnSave" = true;
        "editor.formatOnPaste" = true;

        "terminal.integrated.fontFamily" = "'JetBrainsMono Nerd Font Mono'";

        "git.autofetch" = true;
        "git.confirmSync" = false;
        "git.enableSmartCommit" = true;

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
