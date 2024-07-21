{ lib, pkgs, config, ... }:
let cfg = config.desktop.programs.development;
in {
  options = {
    desktop.programs.development = {
      enable = lib.mkEnableOption "Enable development suite of gui applications";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode;

      enableUpdateCheck = true;
      enableExtensionUpdateCheck = true;

      extensions = with pkgs.vscode-extensions; [
        catppuccin.catppuccin-vsc-icons

        jnoortheen.nix-ide
      ];

      userSettings = {
        "workbench.colorTheme" = "Stylix";
        "workbench.iconTheme" = "catppuccin-mocha";

        "editor.fontFamily" = "'JetBrainsMono Nerd Font Mono'";
        "terminal.integrated.fontFamily" = "'JetBrainsMono Nerd Font Mono'";
      };
    };
  };
}
