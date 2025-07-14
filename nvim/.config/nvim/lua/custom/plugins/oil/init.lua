return {
  {
    'stevearc/oil.nvim',
    config = function()
      vim.keymap.set('n', '<leader>sv', vim.cmd.Oil)
      require('oil').setup {
        default_file_explorer = true,
        dependencies = { { 'echasnovski/mini.icons', opts = { style = 'glyph' } } },
        columns = {
          'icon',
        },
        skip_confirm_for_simple_edits = false,
        keymaps = {
          ['<C-p>'] = 'actions.preview',
          ['<C-c>'] = '',
          ['<C-l>'] = 'actions.refresh',
        },
        view_options = {
          show_hidden = true,
        },
        preview = {
          max_width = 0.9,
          min_width = { 40, 0.4 },
          width = nil,
          max_height = 0.9,
          min_height = { 5, 0.1 },
          height = nil,
          border = 'rounded',
          win_options = {
            winblend = 0,
          },
        },
      }
    end,
  },
}
