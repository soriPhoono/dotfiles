{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Core development packages
    imagemagick
    mkdocs

    # Bash development deps
    nodePackages.bash-language-server
    shfmt

    # Haskell
    haskell.package-list

    # C/C++ development deps
    clang-tools
    lldb
    meson

    # Zig development deps
    zig
    zls

    # Rust development deps
    rustc
    clippy
    rustfmt
    cargo
    rust-analyzer

    # OpenJDK development deps
    jdk
    jdt-language-server

    # Python development deps
    python3

    # Web/JavaScript
    sass
    bun
    nodePackages.typescript-language-server

    # GUI development tools
    logseq
    gimp
  ];

  programs = {
    jq.enable = true;
  };
}
