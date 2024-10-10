final: prev: {
  ags = prev.ags.overrideAttrs
    (old: { buildInputs = old.buildInputs ++ [ pkgs.libdbusmenu-gtk3 ]; });
}
