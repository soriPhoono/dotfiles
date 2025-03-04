_: _: prev: {
  discord = prev.discord.overrideAttrs (
    _: {
      src = builtins.fetchTarball {
        url = "https://discord.com/api/download?platform=linux&format=tar.gz";
        sha256 = "127mihfmwl4bkawjy9mkrgw4mg3r7zwm9kyrd3x01f7gfihxhpvp";
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
