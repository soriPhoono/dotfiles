{ lib, pkgs, config, ... }:
let cfg = config.userapps;
in {
  options.userapps.development = lib.mkEnableOption "Enable development tools";

  config = lib.mkIf cfg.development {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode.overrideAttrs (_: {
        src = builtins.fetchTarball {
          url = "https://code.visualstudio.com/sha/download?build=stable&os=linux-x64";
          sha256 = "1j9wg42g3m46bm6l6p83h2abqkrb9afvc0b87d54cmdgwj717gnh";
        };
      });

      enableUpdateCheck = true;
      enableExtensionUpdateCheck = true;
      mutableExtensionsDir = false;

      extensions = with pkgs.vscode-extensions; [
        # Global themes
        catppuccin.catppuccin-vsc-icons

        # Global tooling
        github.copilot
        github.copilot-chat

        # nix
        jnoortheen.nix-ide
        mkhl.direnv

        # zig
        ziglang.vscode-zig

        # rust
        tamasfe.even-better-toml
        vadimcn.vscode-lldb
        rust-lang.rust-analyzer
      ];

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
        "git.confirmSync" = false;
        "git.enableSmartCommit" = true;

        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nixd";
        "nix.serverSettings" = {
          nixd = {
            formatting = {
              command = [
                "nixpkgs-fmt"
              ];
            };
            options = {
              home_manager = {
                expr = "(builtins.getFlake ${./.}).homeConfigurations.soriphoono.options";
              };
            };
          };
        };
      };
    };
  };
}
