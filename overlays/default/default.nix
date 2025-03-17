_: _: prev: {
  discord = prev.discord.overrideAttrs (
    _: {
      src = builtins.fetchTarball {
        url = "https://discord.com/api/download?platform=linux&format=tar.gz";
        sha256 = "07h735lzx70ghrddv0krahm1sqjcxx52wlpy7fsi17gqxix1mbrr";
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
