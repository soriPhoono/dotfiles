{
  lib,
  config,
  ...
}: let
  cfg = config.hyprland;
in {
  options.hyprland = let
    mkListOfStr = description:
      lib.mkOption {
        inherit description;
        type = with lib.types; listOf str;

        default = [];
      };
  in {
    windowRules = mkListOfStr "Window rules for Hyprland.";

    animations = {
      curves = mkListOfStr "Animation curves for Hyprland.";
      animationRules = mkListOfStr "Animation rules for Hyprland.";
    };
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = {
      windowrulev2 = cfg.windowRules;

      bezier = cfg.animations.curves;
      animation = cfg.animations.animationRules;
    };
  };
}
