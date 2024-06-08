{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Core development packages
    gitkraken

    # Nix development deps
    nil
    nixpkgs-fmt

    # Rust development deps
    cargo
    clippy
    rustc
    rustfmt
    rust-analyzer
  ];
}
