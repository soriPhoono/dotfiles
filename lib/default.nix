{lib, ...}: {
  soriphoono = rec {
    filesOf = path:
      lib.filterAttrs
      (name: type: type == "regular")
      (builtins.readDir path);

    dirsOf = path:
      lib.filterAttrs
      (name: type: type == "directory")
      (builtins.readDir path);

    load = entries: f:
      lib.genAttrs
      (lib.mapAttrsToList
        (name: type: lib.removeSuffix ".nix" name)
        (lib.filterAttrs
          (name: type: lib.hasSuffix ".nix" name || type == "directory")
          entries))
      (name: f name);
  };
}
