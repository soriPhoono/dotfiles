{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Core development packages
    gitkraken

    # Nix development deps
    nil
    nixpkgs-fmt

    # Bash development deps
    nodePackages.bash-language-server
    shfmt

    # C/C++ development deps
    

    # Rust development deps
    cargo
    clippy
    rustc
    rustfmt
    rust-analyzer
  ];
}
