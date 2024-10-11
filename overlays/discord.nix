final: prev: {
  discord = prev.discord.overrideAttrs (_: {
    src = builtins.fetchTarball {
      url = "https://discord.com/api/download?platform=linux&format=tar.gz";
      sha256 = "0njwcnrn2br47dzqvmlazcmf63bblx68775f0kv8djwxfvg977im";
    };
  });
}
