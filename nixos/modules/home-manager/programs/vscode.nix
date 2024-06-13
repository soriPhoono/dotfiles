{ pkgs, ... }: {
  programs = {
    vscode = {
      enable = true;
      package = pkgs.vscode;

      mutableExtensionsDir = false; # TODO: uncomment this when vscode setup is finished

      extensions = with pkgs.vscode-extensions; [
        # Themes
        catppuccin.catppuccin-vsc-icons

        # Core extensions
        editorconfig.editorconfig
        christian-kohler.path-intellisense
        gruntfuggly.todo-tree

        visualstudioexptteam.vscodeintellicode
        visualstudioexptteam.intellicode-api-usage-examples

        github.copilot

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
        ms-vscode.cpptools
        ms-vscode.cmake-tools
        llvm-vs-code-extensions.vscode-clangd
        vadimcn.vscode-lldb

        # Zig
        ziglang.vscode-zig

        # Rust
        rust-lang.rust-analyzer
        tamasfe.even-better-toml

        # Java
        redhat.java
        vscjava.vscode-java-debug
        vscjava.vscode-maven
        vscjava.vscode-java-test

        # Python
        ms-python.python
        ms-python.isort
        ms-python.vscode-pylance
        ms-python.debugpy

        ms-toolsai.vscode-jupyter-cell-tags
        ms-toolsai.jupyter-keymap
        ms-toolsai.jupyter-renderers
        ms-toolsai.vscode-jupyter-slideshow

        # Ruby
        shopify.ruby-lsp

        # Go
        golang.go

        # Lua
        sumneko.lua

        # Flutter
        dart-code.dart-code
        dart-code.flutter

        # JavaScript/TypeScript
        vscjava.vscode-gradle
        bradlc.vscode-tailwindcss
        svelte.svelte-vscode

        # XML
        redhat.vscode-xml

        # YAML
        redhat.vscode-yaml

        # Markdown
        bierner.markdown-mermaid
        bierner.markdown-emoji
        bierner.markdown-checkbox
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
