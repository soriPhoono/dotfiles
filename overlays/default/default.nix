_: _: prev: {
  discord = prev.discord.overrideAttrs (
    _: {
      src = builtins.fetchTarball {
        url = "https://discord.com/api/download?platform=linux&format=tar.gz";
        sha256 = "1lfrnkq7qavlcbyjzn2m8kq39wn82z40dkpn6l5aijy12c775x7s";
      };
    }
  ); # Auto update discord on rebuild

  gnome = prev.gnome.overrideScope (_: gsuper: {
    nautilus = gsuper.nautilus.overrideAttrs (nsuper: {
      buildInputs =
        nsuper.buildInputs
        ++ (with prev.gst_all_1; [
          gst-plugins-good
          gst-plugins-bad
        ]);
    });
  }); # Correct nautilus GStreamer plugins

  lldb = prev.lldb.overrideAttrs {
    dontCheckForBrokenSymlinks = true;
  };
}
