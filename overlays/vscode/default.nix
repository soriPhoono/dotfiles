{ ...
}: self: super: {
  vscode = super.vscode.overrideAttrs (
    _: {
      src = builtins.fetchTarball {
        url = "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64";
        sha256 = "";
      };
    }
  );
}
