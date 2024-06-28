{ pkgs, ... }: {
  imports = [
    ./git.nix

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
}
