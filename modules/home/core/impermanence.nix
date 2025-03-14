{
  lib,
  config,
  ...
}: let
  cfg = config.core.impermanence;
in {
  options.core.impermanence = {
    directories = lib.mkOption {
      type = with lib.types; listOf (oneOf [str (attrsOf str)]);

      default = [];

      description = "A list of directories to be persisted.";
    };

    files = lib.mkOption {
      type = with lib.types; listOf (oneOf [str (attrsOf str)]);

      default = [];

      description = "A list of files to be persisted.";
    };
  };

  config = {
    home.persistence."/persist/home/${config.home.username}" = {
      inherit (cfg) files;

      directories =
        [
          "Documents"
          "Downloads"
          "Music"
          "Pictures"
          "Videos"
        ]
        ++ cfg.directories;

      allowOther = true;
    };
  };
}
