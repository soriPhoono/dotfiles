_: _: prev: {
  discord = prev.discord.overrideAttrs (
    _: {
      src = builtins.fetchTarball {
        url = "https://discord.com/api/download?platform=linux&format=tar.gz";
        sha256 = "07h735lzx70ghrddv0krahm1sqjcxx52wlpy7fsi17gqxix1mbrr";
      };
    }
  ); # Auto update discord on rebuild
}
