final: prev: {
  ags = prev.ags.overrideAttrs
    (old: { buildInputs = old.buildInputs ++ [ old.libdbusmenu-gtk3 ]; });
}
