{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Core development packages
    imagemagick
    unzip
    unrar
    p7zip
    mkdocs

    # Bash development deps
    nodePackages.bash-language-server
    shfmt

    # Haskell
    haskell.package-list

    # C/C++ development deps
    gcc
    gdb
    ninja
    cmake
    clang-tools
    lldb
    meson

    # Zig development deps
    zig
    zls

    # Rust development deps
    rustup

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
    gitkraken
    logseq
    gimp
  ];

  programs = {
    jq.enable = true;
  };
}
