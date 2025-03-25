_: _: prev: {
  lldb = prev.lldb.overrideAttrs {
    dontCheckForBrokenSymlinks = true;
  }; # To fix issue compiling from source lldb
}
