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

      extensions = with pkgs.vscode-extensions; [
        catppuccin.catppuccin-vsc-icons

        ms-vsliveshare.vsliveshare

        ms-vscode.hexeditor

        github.copilot
        github.copilot-chat

        editorconfig.editorconfig
        eamodio.gitlens

        ms-vscode-remote.remote-ssh
        ms-vscode-remote.remote-ssh-edit

        mads-hartmann.bash-ide-vscode
        ms-vscode.powershell

        jnoortheen.nix-ide

        ms-vscode.cpptools-extension-pack
        llvm-vs-code-extensions.vscode-clangd
        mesonbuild.mesonbuild

        vadimcn.vscode-lldb

        ziglang.vscode-zig

        rust-lang.rust-analyzer
        tamasfe.even-better-toml

        vscjava.vscode-java-pack

        ms-python.python
        # Pylint
        # Autodocstring
        # Autopep8
        # ISort
        # Python indent
        # MyPy type checker
        # Django
        # Jinja
        # Jupyter

        # ESLint
        # Sass

        # Go plugin

        # Dart plugin
        # Flutter plugin
      ];

      userSettings = {
        "window.titleBarStyle" = "custom";
        "window.dialogStyle" = "custom";
        "window.menuBarVisibility" = "compact";

        "workbench.iconTheme" = "catppuccin-mocha";

        "files.autoSave" = "onFocusChange";

        "editor.fontFamily" = "'JetBrainsMono Nerd Font Mono'";
        "editor.formatOnSave" = true;
        "editor.formatOnPaste" = true;

        "terminal.integrated.fontFamily" = "'JetBrainsMono Nerd Font Mono'";

        "git.autofetch" = true;
        "git.confirmSync" = false;
        "git.enableSmartCommit" = true;

        "nix.enableLanguageServer" = true; // Enable LSP.
        "nix.serverPath" = "nil"; // The path to the LSP server executable.
      };
    };
  };
}
