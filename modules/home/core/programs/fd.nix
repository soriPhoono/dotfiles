{
  lib,
  config,
  ...
}: let
  cfg = config.core.programs.fd;
in {
  options.core.programs.fd = {
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
