{ lib, pkgs, config, ... }:
let cfg = config.programs.development;
in {
  options = {
    programs.development.enable = lib.mkEnableOption "Enable development programs";
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

      zig

      rustup

      jdk

      python3

      sass

      qmk
    ];
  }
}
