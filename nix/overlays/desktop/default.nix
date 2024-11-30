{ ... }:
final: prev: {
  discord = prev.discord.overrideAttrs (_: {
    src = builtins.fetchTarball {
      url = "https://discord.com/api/download?platform=linux&format=tar.gz";
      sha256 = "0njwcnrn2br47dzqvmlazcmf63bblx68775f0kv8djwxfvg977im";
    };
  });

  vscode = prev.vscode.overrideAttrs (_: {
    src = builtins.fetchTarball {
      url = "https://code.visualstudio.com/sha/download?build=stable&os=linux-x64";
      sha256 = "1j9wg42g3m46bm6l6p83h2abqkrb9afvc0b87d54cmdgwj717gnh";
    };
  });
}
