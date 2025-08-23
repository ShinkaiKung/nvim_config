return {
    "hrsh7th/nvim-cmp",
    enabled = true,
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "saadparwaiz1/cmp_luasnip",
        "L3MON4D3/LuaSnip",
        "kdheepak/cmp-latex-symbols",
        "liamvdvyver/cmp-bibtex",
        "micangl/cmp-vimtex",
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            completion = {
                autocomplete = { 'TextChanged' },
                completeopt = 'menu,menuone,noselect',
                keyword_length = 2,
            },
            sources = cmp.config.sources({
                { name = "luasnip",       priority = 1000 },
                { name = "nvim_lsp",      priority = 900 },
                { name = "vimtex",        priority = 1200 }, -- VimTeX 公式/环境
                -- { name = "latex_symbols", priority = 1100 }, -- 数学符号
                { name = "bibtex",        priority = 1000 }, -- 文献引用
            }, {
                { name = "buffer", priority = 500 },
                { name = "path",   priority = 250 },
            }),
            mapping = cmp.mapping.preset.insert({
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
        })
    end,
}
