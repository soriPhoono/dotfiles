{ ... }: self: super: {
  discord = super.discord.overrideAttrs (
    _: {
      src = builtins.fetchTarball {
        url = "https://discord.com/api/download?platform=linux&format=tar.gz";
        sha256 = "1zlzd5q547idvsw4gxicwicy7x1mgvvx1mpy734kxfpld0752dj1";
      };
    }
  );
}
