{ lib
, pkgs
, config
, ...
}:
let
  cfg = config.terminal.programs.development;
in
{
  options = {
    terminal.programs.development.enable = lib.mkEnableOption "Enable development programs";
  };

  imports = [
    ./nvim.nix
  ];

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs;
      [
        mkdocs

        nixd

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

    programs.helix = {
      enable = true;
      defaultEditor = true;

      settings = {
        editor = {
          auto-save = true;

          statusline = {
            left = [
              "mode"
              "version-control"
              "file-base-name"
              "file-modification-indicator"
            ];
            right = [ "diagnostics" "file-type" "position-percentage" ];

            mode = {
              normal = "󰋜";
              insert = "󰏪";
              select = "󰍉";
            };
          };

          cursor-shape = {
            normal = "block";
            insert = "bar";
            select = "underline";
          };
        };
      };
    };
  };
}
