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
          read -rp "What is your commit message"
          git commit -am "$REPLY"
          git push
        '';
    })
  ];
}
