{
  lib,
  config,
  ...
}: let
  cfg = config.userapps.programs.thunderbird;
in {
  options.userapps.programs.thunderbird.enable = lib.mkEnableOption "Enable thunderbird mail client";

  config = lib.mkIf cfg.enable {
    programs.thunderbird = {
      enable = true;

      profiles.default.isDefault = true;
    };

    core.impermanence.directories = [
      ".thunderbird" # TODO: update this when personal email is online
    ];
  };
}
