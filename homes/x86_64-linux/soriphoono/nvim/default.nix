{
  imports = [
    ./plugins/codeium.nix
    ./plugins/assistant.nix
    ./plugins/autocomplete.nix
    ./plugins/autopairs.nix
    ./plugins/binds.nix
    ./plugins/comment.nix
    ./plugins/dashboard.nix
    ./plugins/debugger.nix
    ./plugins/diagnostics.nix
    ./plugins/filetree.nix
    ./plugins/formatter.nix
    ./plugins/languages.nix
    ./plugins/lsp.nix
    ./plugins/notes.nix
  ];

  programs.nvf = {
    enable = true;

    settings.vim = {
      viAlias = false;
      vimAlias = true;

      enableLuaLoader = true;

      bell = "on";
      hideSearchHighlight = true;

      git.enable = true;
      notify.nvim-notify.enable = true;
      presence.neocord.enable = true;
      snippets.luasnip.enable = true;
      spellcheck = {
        enable = true;
        programmingWordList.enable = true;
      };
      statusline.lualine = {
        enable = true;
      };
      syntaxHighlighting = true;
      tabline.nvimBufferline.enable = true;
      telescope.enable = true;
      terminal.toggleterm.enable = true;
      theme = {
        enable = true;
        name = "catppuccin";
        transparent = true;
      };

      treesitter = {
        enable = true;
        autotagHtml = true;
        fold = true;
      };

      ui = {
        borders.enable = true;
        breadcrumbs.enable = true;
        fastaction.enable = true;
        modes-nvim.enable = true;
        noice.enable = true;
        nvim-ufo.enable = true;
        smartcolumn.enable = true;
      };

      undoFile.enable = true;

      utility = {
        ccc.enable = true;
        icon-picker.enable = true;
        images.image-nvim.enable = true;
        surround.enable = true;
      };

      visuals = {
        cinnamon-nvim.enable = true;
        fidget-nvim.enable = true;
        highlight-undo.enable = true;
        indent-blankline.enable = true;
        nvim-cursorline.enable = true;
        nvim-scrollbar.enable = true;
        nvim-web-devicons.enable = true;
        rainbow-delimiters.enable = true;
      };

      # extraPackages = with pkgs; [
      # ];
    };
  };
}
