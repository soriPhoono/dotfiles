{
  plugins = {
    nui.enable = true;

    notify = {
      enable = true;

      settings = {
        render = "compact";
        timeout = 2500;
      };
    };

    noice = {
      enable = true;

      settings = {
        presets = {
          bottom_search = true;
          command_palette = true;
          inc_rename = true;
          long_message_to_split = false;
          lsp_doc_border = true;
        };

        lsp.override = {
          "cmp.entry.get_documentation" = true;
          "vim.lsp.util.convert_input_to_markdown_lines" = true;
          "vim.lsp.util.stylize_markdown" = true;
        };
      };
    };
  };
}
