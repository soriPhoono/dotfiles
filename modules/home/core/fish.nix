{ pkgs, host, ... }: {
  programs.fish = {
    enable = true;

    shellAliases = {
      g = "git";
      v = "nvim";

      cat = "bat";

      rebuild =
        let
          rebuild_script = pkgs.writeShellApplication {
            name = "rebuild";

            runtimeInputs = [

            ];

            text = ''
              sudo nixos-rebuild switch --flake .#${host}

              nix-index
            '';
          };
        in "${rebuild_script}";
    };

    shellInitLast = ''
      set fish_greeting

      fastfetch
    '';
  };
}
