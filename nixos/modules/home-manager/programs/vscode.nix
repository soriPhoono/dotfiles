{ pkgs, ... }: {
  programs = {
    vscode = {
      enable = true;
      package = pkgs.vscode;

      # mutableExtensionsDir = false; # TODO: uncomment this when vscode setup is finished

      extensions = with pkgs.vscode-extensions; [
        # Themes
        catppuccin.catppuccin-vsc-icons

        # Core extensions
        editorconfig.editorconfig
        christian-kohler.path-intellisense

        # Copilot
        github.copilot

        # Git support
        eamodio.gitlens

        # Nix support
        jnoortheen.nix-ide

        # Bash
        mads-hartmann.bash-ide-vscode
        foxundermoon.shell-format

        # Haskell
        haskell.haskell

        # Lua
        sumneko.lua

        # C/C++
        ms-vscode.cmake-tools
        llvm-vs-code-extensions.vscode-clangd
        vadimcn.vscode-lldb

        # Zig
        ziglang.vscode-zig

        # Rust
        rust-lang.rust-analyzer

        # Java
        vscjava.vscode-java-pack

        # Python
        ms-python.python
      ];

      userSettings = {
        "window.titleBarStyle" = "custom";

        "workbench.iconTheme" = "catppuccin-mocha";
        "workbench.editor.editorActionsLocation" = "hidden";

        "editor.smoothScrolling" = true;
        "editor.fontSize" = 16;

        "explorer.confirmDelete" = false;

        "git.autofetch" = true;
        "git.enableSmartCommit" = true;
        "git.confirmSync" = false;

        "nix.enableLanguageServer" = "true";
        "nix.serverPath" = "${pkgs.nil}/bin/nil";
        "nix.serverSettings" = {
          "autofetch" = true;
          "nil" = {
            "formatting" = {
              "command" = [ "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt" ];
            };
          };
        };
      };
    };
  };
}
