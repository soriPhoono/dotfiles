{
  lib,
  pkgs,
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

      base16Scheme = let
        base16-catppuccin = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "base16";
          rev = "99aa911";
          sha256 = "HHodDRrlcBVWGE3MN0i6UvUn30zY/JFEbgeUpnZG5C0=";
        };
      in "${base16-catppuccin}/base16/frappe.yaml";
    };
  };
}
