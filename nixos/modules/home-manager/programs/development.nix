{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Core development packages
    imagemagick

    unzip
    unrar
    p7zip

    mkdocs

    qmk

    # C/C++ development deps
    gcc
    gdb
    ninja
    cmake

    # Zig development deps
    zig
    zls

    # Rust development deps
    rustup

    # OpenJDK development deps
    jdk

    # Python development deps
    python3

    # Web/JavaScript
    sass

    # GUI development tools
    gitkraken
    obsidian
    gimp
  ];

  programs = {
    git = {
      enable = true;

      userName = "soriphoono";
      userEmail = "soriphoono@gmail.com";

      includes = [
        # TODO: setup sops-nix to store school git data
      ];

      extraConfig = {
        init.defaultBranch = "main";
        url."git@github.com/" = {
          insteadOf = [
            "gh:"
            "github:"
          ];
        };
        pull.rebase = false;
      };

      delta = {
        enable = true;

        options = {
          dark = true;
          line-numbers = true;
          side-by-side = true;
          hyperlinks = true;

          # TODO: add to nixpkgs the github repo open-in-editor and replace this line
          hyperlinks-file-link-format = "vscode://file/{path}:{line}";

          # true-color = "always";
          diff.colorMoved = "default";
          merge.conflictstyle = "diff3";
        };
      };
    };

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

        # Lua
        sumneko.lua

        # C/C++
        ms-vscode.cpptools
        ms-vscode.cmake-tools

        # Zig
        ziglang.vscode-zig
        vadimcn.vscode-lldb

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

        # Go
        golang.go

        # Flutter
        dart-code.dart-code
        dart-code.flutter

        # JavaScript/TypeScript
        bradlc.vscode-tailwindcss
        svelte.svelte-vscode

        # XML
        redhat.vscode-xml

        # YAML
        redhat.vscode-yaml
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
