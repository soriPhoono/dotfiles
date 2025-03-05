_: prev: {
  discord = prev.discord.overrideAttrs (
    _: {
      src = builtins.fetchTarball {
        url = "https://discord.com/api/download?platform=linux&format=tar.gz";
        sha256 = "1lfrnkq7qavlcbyjzn2m8kq39wn82z40dkpn6l5aijy12c775x7s";
      };
    }
  ); # Auto update discord on rebuild

  lldb = prev.lldb.overrideAttrs {
    dontCheckForBrokenSymlinks = true;
  };
}
