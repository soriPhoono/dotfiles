{ pkgs, ... }: {
  imports = [ ../nvim ];

  home.packages = with pkgs; [
    # Documentation generator
    mkdocs

    # C/C++ development deps
    gcc
    gdb

    clang-tools
    lldb

    ninja
    cmake
    # TODO: setup clangd and meson

    # Zig development deps
    zig

    # Rust development deps
    rustup # TODO: learn how to declare rust compiler declaratively

    # OpenJDK development deps
    jdk

    # Python development deps
    python3

    # Web/JavaScript
    sass

    # Keyboard firmware development
    qmk

    # markdown tools
    obsidian
  ];

  programs.git = {
    enable = true;

    userName = "soriphoono";
    userEmail = "soriphoono@gmail.com";

    includes = [
      # TODO: setup sops-nix to store school git data
    ];

    extraConfig = {
      init.defaultBranch = "main";
      url."git@github.com/" = { insteadOf = [ "gh:" "github:" ]; };
      pull.rebase = false;
    };

    delta = {
      enable = true;

      options = {
        dark = true;
        line-numbers = true;
        side-by-side = true;

        # true-color = "always";
        diff.colorMoved = "default";
        merge.conflictstyle = "diff3";
      };
    };
  };
}
