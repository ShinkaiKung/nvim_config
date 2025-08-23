return {
  "L3MON4D3/LuaSnip",
  dependencies = { "iurimateus/luasnip-latex-snippets.nvim" },
  config = function()
    require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/LuaSnip/" })
    require("luasnip").config.setup({
      update_events = "TextChanged,TextChangedI",
      enable_autosnippets = true,
    })
  end,
}
