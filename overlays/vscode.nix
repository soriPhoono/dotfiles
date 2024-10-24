final: prev: {
  vscode-fhs = prev.vscode-fhs.overrideAttrs (_: {
    src = builtins.fetchTarball {
      url = "https://code.visualstudio.com/sha/download?build=stable&os=linux-x64";
      sha256 = "106gy3w46js6kji4lf0klgi1rjdwbpdi5i2gm4jjxsiki45bz6qk";
    };
  });
}
