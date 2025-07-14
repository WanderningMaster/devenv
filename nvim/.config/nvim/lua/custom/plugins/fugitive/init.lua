return {
  {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set('n', '<leader>gdf', function()
        vim.cmd 'Git diff'
      end)
    end,
  },
}
