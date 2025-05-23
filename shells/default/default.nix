{
  pkgs,
  mkShell,
  ...
}:
mkShell {
  packages = with pkgs; [
    disko
    nixos-facter

    age
    sops
    ssh-to-age

    (pkgs.writeShellApplication {
      name = "quick_commit.sh";
      text =
        # bash
        ''
          eval "$(ssh-agent -s)"
          ssh-add ~/.ssh/id_ed25519

          read -rp "What is your commit message: "
          git commit -am "$REPLY"

          pkill ssh-agent
        '';
    })

    (pkgs.writeShellApplication {
      name = "quick_push.sh";
      text =
        # bash
        ''
          eval "$(ssh-agent -s)"
          ssh-add ~/.ssh/id_ed25519

          git push

          pkill ssh-agent
        '';
    })

    (pkgs.writeShellApplication {
      name = "quick_pull.sh";
      text =
        # bash
        ''
          eval "$(ssh-agent -s)"
          ssh-add ~/.ssh/id_ed25519

          git pull

          pkill ssh-agent
        '';
    })
  ];
}
