{ lib, pkgs, config, ... }:
let cfg = config.terminal.programs.development;
in {
  options = {
    terminal.programs.development.enable = lib.mkEnableOption "Enable development programs";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      mkdocs

      gcc
      gdb
      clang-tools
      lldb
      ninja
      cmake
      meson

      qmk

      zig

      rustup

      jdk

      python3

      nodejs_22
      sass
    ];
  };
}
