{
  lib,
  config,
  ...
}: let
  cfg = config.theme.font;
in
  with lib; {
    options.theme.font = let
      mkFontOption = {
        package = mkOption {
          type = with types; nullOr package;
          default = null;
          description = "Package providing the font.";
          example = pkgs.nerd-fonts.SauceCodePro;
        };

        name = mkOption {
          type = types.str;
          default = null;
          description = "Name of the font.";
          example = "SauceCodePro Nerd Font Propo";
        };
      };
    in
      if config.desktop.enable
      then {
        serif = mkFontOption;
        sansSerif = mkFontOption;
        monospace = mkFontOption;
        emoji = mkFontOption;
      }
      else {};
  }
