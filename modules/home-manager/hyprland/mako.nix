{ pkgs, ... }: {
  services.mako = {
    enable = true;
    layer = "top";
    margin = "20";
    maxVisible = 3;
    actions = true;
    anchor = "bottom-right";

    defaultTimeout = 5000;
    borderSize = 3;
    borderRadius = 7;

    iconPath = "${pkgs.papirus-icon-theme}/usr/share/icons/hicolor;${pkgs.papirus-icon-theme}/usr/share/icons/pixmaps";
  };
}
