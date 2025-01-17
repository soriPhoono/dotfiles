{lib, ...}: {
  soriphoono = rec {
    checkDir = path: f: default:
      if builtins.pathExists path
      then f path
      else default;

    load = files: f:
      lib.genAttrs
      (lib.mapAttrsToList
        (name: type: lib.removeSuffix ".nix" name)
        (lib.filterAttrs
          (name: type: lib.hasSuffix ".nix" name && type == "regular")
          files))
      (name: f name);

    loadForSystem = {
      path,
      system,
      args ? {inherit lib;},
    }:
      checkDir path (
        path:
          (load (builtins.readDir path) (name: import "${path}/${name}.nix" args))
          // (
            checkDir "${path}/${system}" (
              path:
                load (builtins.readDir path) (name: import "${path}/${name}.nix" args)
            ) {}
          )
      ) {};
  };
}
