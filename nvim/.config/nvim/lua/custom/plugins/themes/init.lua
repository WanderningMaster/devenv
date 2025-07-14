return {
  { -- You can easily change to a different colorscheme.
    'rose-pine/neovim',
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require('rose-pine').setup {
        styles = {
          transparency = true,
        },
      }
    end,
    init = function()
      vim.cmd.colorscheme 'rose-pine'

      vim.cmd.hi 'Comment gui=none'
    end,
  },
  -- {
  --   'EdenEast/nightfox.nvim',
  --   lazy = false,
  --   priority = 1000,
  --   init = function()
  --     vim.cmd.colorscheme 'duskfox'
  --
  --     vim.cmd.hi 'Comment gui=none'
  --   end,
  -- },
}
