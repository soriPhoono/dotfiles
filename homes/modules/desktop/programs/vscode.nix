{ lib, pkgs, config, ... }: 
let cfg = config.desktop.programs.vscode;
in {
  options = {
    desktop.programs.vscode.enable = lib.mkEnableOption "Enable vscode editor support";
  };

  config = lib.mkIf cfg.enable {
    programs.vscode = {
      enable = true;

      mutableExtensionsDir = false;

      extensions = with pkgs.vscode-extensions; [
        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons

        github.copilot
        
        ms-vscode-remote.remote-ssh
        ms-vscode-remote.remote-ssh-edit

        # Nix
        jnoortheen.nix-ide
        mkhl.direnv

        # Bash
        mads-hartmann.bash-ide-vscode

        # C/C++
        ms-vscode.cpptools
        ms-vscode.cmake-tools

        # Zig + Rust
        vadimcn.vscode-lldb
        ziglang.vscode-zig
        rust-lang.rust-analyzer

        # Java
        redhat.java
        vscjava.vscode-java-test
        vscjava.vscode-java-debug
        vscjava.vscode-maven

        # Python
        ms-python.python
        ms-python.debugpy
        ms-python.vscode-pylance
        matangover.mypy
        ms-python.isort
        wholroyd.jinja
        batisteo.vscode-django

        # Javascript + Typescript
        dbaeumer.vscode-eslint
        svelte.svelte-vscode

        # Dart
        dart-code.dart-code
        dart-code.flutter

        # Misc
        dotjoshjohnson.xml
        redhat.vscode-yaml
        tamasfe.even-better-toml
      ];
    };
  };
}
