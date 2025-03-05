{lib, ...}: rec {
  load_modules = registry:
    lib.mapAttrs
    (_: args: hook_action args.cwd args.action args)
    registry;

  hook_action = cwd: action: args:
    lib.mapAttrs
    (dir: _:
      action "${cwd}/${dir}/default.nix" args)
    (
      lib.filterAttrs
      (dir: type: type == "directory" && builtins.pathExists "${cwd}/${dir}/default.nix")
      (builtins.readDir cwd)
    );
}
