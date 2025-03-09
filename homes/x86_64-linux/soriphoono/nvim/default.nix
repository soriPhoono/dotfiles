{
  imports = [
    ./plugins/dashboard.nix
    ./plugins/filetree.nix
    ./plugins/statusline.nix
    ./plugins/binds.nix
    ./plugins/languages.nix
    ./plugins/lsp.nix
    ./plugins/codeium.nix
    ./plugins/autocomplete.nix
    ./plugins/debugger.nix
    ./plugins/notes.nix
  ];

  programs.nvf = {
    enable = true;

    settings.vim = {
      viAlias = false;
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

      theme = {
        enable = true;
        transparent = true;
      };

      ui = {
        borders.enable = true;
        breadcrumbs.enable = true;

        noice = {
          enable = true;

          setupOpts = {
            lsp.signature.enabled = true;
            presets.inc_rename = true;
          };
        };

        smartcolumn.enable = true;
      };

      visuals = {
        nvim-web-devicons.enable = true;
        cinnamon-nvim.enable = true;
        indent-blankline.enable = true;
        rainbow-delimiters.enable = true;
      };

      utility = {
        icon-picker.enable = true;
        images.image-nvim = {
          enable = true;

          setupOpts = {
            backend = "kitty";

            maxWidthWindowPercentage = 50;

            integrations = {
              markdown = {
                enable = true;
                clearInInsertMode = true;
                downloadRemoteImages = true;
              };
              neorg = {
                enable = true;
                clearInInsertMode = true;
                downloadRemoteImages = true;
              };
            };
          };
        };
      };
      autopairs.nvim-autopairs.enable = true;
      comments.comment-nvim.enable = true;

      treesitter = {
        enable = true;
        autotagHtml = true;
      };

      telescope.enable = true;
    };
  };
}
