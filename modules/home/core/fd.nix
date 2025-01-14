{ lib, config, ... }:
let
  cfg = config.core.fd;
in
{
  options.core.fd = {
    enable = lib.mkEnableOption "Enable fd";
  };

  config = lib.mkIf cfg.enable {
    programs.fd = {
      enable = true;
      hidden = true;

      extraOptions = [
        "--follow"
        "--color=always"
      ];

      ignores = [
        ".git"
        "*.bak"
      ];
    };
  };
}
