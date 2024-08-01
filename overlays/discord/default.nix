{ ...
}: self: super: {
  discord = super.discord.overrideAttrs (
    _: {
      src = builtins.fetchTarball {
        url = "https://discord.com/api/download?platform=linux&format=tar.gz";
        sha256 = "0k843yfnxj1hnw3bmki13625ywfy3k0pf5xlng0xmaacz2jf3lkk";
      };
    }
  );
}
