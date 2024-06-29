{ pkgs, ... }: {
  imports = [
    ../nvim
  ];

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
    meson

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

        # true-color = "always";
        diff.colorMoved = "default";
        merge.conflictstyle = "diff3";
      };
    };
  };
}
