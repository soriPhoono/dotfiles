{pkgs, ...}: {
  imports = [
    ./plugins
  ];

  home.packages = with pkgs; [
    ueberzug
  ];

  programs.nvf = {
    enable = true;

    settings.vim = {
      viAlias = true;
      vimAlias = true;

      bell = "on";
      hideSearchHighlight = true;

      globals = {
        mapleader = " ";
        maplocalleader = " ";
      };

      options = {
        shiftwidth = 2;
        tabstop = 2;
        expandtab = true;

        foldenable = false;
        wrap = false;
      };

      git.enable = true;
      undoFile.enable = true;

      spellcheck = {
        enable = true;
        programmingWordlist.enable = true;
      };
    };
  };
}
