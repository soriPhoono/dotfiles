final: prev: {
  ags = prev.ags.overrideAttrs
    (old: { buildInputs = old.buildInputs ++ [ prev.libdbusmenu-gtk3 ]; });
}
