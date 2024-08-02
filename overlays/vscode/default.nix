{ ... }: self: super: {
  discord = super.discord.overrideAttrs (
    _: {
      src = builtins.fetchTarball {
        url = "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64";
        sha256 = "0k843yfnxj1hnw3bmki13625ywfy3k0pf5xlng0xmaacz2jf3lkk";
      };
    }
  );
}
