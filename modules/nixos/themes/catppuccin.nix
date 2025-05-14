{
  lib,
  config,
  ...
}: let
  cfg = config.themes.catppuccin;
in {
  options.themes.catppuccin.enable = lib.mkEnableOption "Enable catppuccin colorscheme";

  config = lib.mkIf cfg.enable {
    themes.enable = true;

    stylix = {
      image = ../../../assets/wallpapers/catppuccin-mountain.jpg;
    };

    home-manager.users = lib.listToAttrs (map (user: {
        inherit (user) name;

        value = {
          themes.catppuccin.enable = true;
        };
      })
      config.core.users);
  };
}
