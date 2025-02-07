_: final: prev: {
  discord = prev.discord.overrideAttrs (
    _: {src = builtins.fetchTarball "https://discord.com/api/download?platform=linux&format=tar.gz";}
  ); # Auto update discord on rebuild

  gnome = prev.gnome.overrideScope (gself: gsuper: {
    nautilus = gsuper.nautilus.overrideAttrs (nsuper: {
      buildInputs =
        nsuper.buildInputs
        ++ (with prev.gst_all_1; [
          gst-plugins-good
          gst-plugins-bad
        ]);
    });
  }); # Correct nautilus GStreamer plugins
}
