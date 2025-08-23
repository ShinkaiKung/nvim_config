return {
  {
    -- 启用内置拼写检查
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ltex = {
          settings = {
            ltex = {
              language = "en-US", -- 拼写检查语言
            },
          },
        },
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- 确保加载 latex parser
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "latex" })
    end,
  },
}
