final: prev: {
  vscode-fhs = prev.vscode-fhs.overrideAttrs (_: {
    src = builtins.fetchTarball {
      url = "https://code.visualstudio.com/sha/download?build=stable&os=linux-x64";
      sha256 = "";
    };
  });
}
