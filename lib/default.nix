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

    loadCompilable = {
      path,
      system,
      args ? {inherit lib;},
    }:
      if builtins.pathExists path
      then
        (load (filesOf path) (name: import "${path}/${name}.nix" args))
        // (
          if builtins.pathExists "${path}/${system}"
          then load (filesOf "${path}/${system}") (name: import "${path}/${name}.nix" args)
          else {}
        )
      else {};

    loadModules = path:
      lib.mapAttrs
      (name: type: import "${path}/${name}/default.nix")
      (lib.filterAttrs
        (name: type: builtins.pathExists "${path}/${name}/default.nix")
        (dirsOf path));
  };
}
