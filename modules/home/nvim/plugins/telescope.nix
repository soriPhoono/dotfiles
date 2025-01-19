{
  programs.nixvim.plugins.telescope = {
    enable = true;

    keymaps = {
      "<leader>ff" = "git_files";
      "<leader>fg" = "live_grep";
      "<leader>fd" = "lsp_definitions";
      "<leader>fr" = "lsp_references";
      "<leader>fi" = "lsp_implementations";
      "<leader>fD" = "lsp_type_definitions";
      "<leader>fs" = "lsp_document_symbols";
      "<leader>fw" = "lsp_dynamic_workspace_symbols";
    };

    settings = {
      defaults = {
        path_display = [
          "truncate"
        ];
        preview = {
          treesitter = true;
        };
        color_devicons = true;
        prompt_prefix = " ";
        selection_caret = " ";
        entry_prefix = " ";
        vimgrep_arguments = [
          "rg"
          "-L"
          "--color=never"
          "--no-heading"
          "--with-filename"
          "--line-number"
          "--column"
          "--smart-case"
        ];
      };
    };
  };
}
