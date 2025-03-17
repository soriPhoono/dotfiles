{
  lib,
  config,
  ...
}: let
  cfg = config.userapps.programs.joplin-desktop;
in {
  options.userapps.programs.joplin-desktop.enable = lib.mkEnableOption "Enable Joplin Desktop";

  config = lib.mkIf cfg.enable {
    programs.joplin-desktop.enable = true;

    core.impermanence.directories = [
      ".config/joplin-desktop"
    ];
  };
}
