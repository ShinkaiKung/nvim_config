return {
  {
    "lervag/vimtex",
    ft = { "tex" },
    config = function()
      -- === 使用 Tectonic 编译器 ===
      vim.g.vimtex_compiler_method = "tectonic"
      vim.g.vimtex_compiler_tectonic = {
        executable = "tectonic",
        options = {
          "--synctex",
          "--keep-logs",
          "--keep-intermediates",
        },
      }

      -- === PDF 查看器 ===
      vim.g.vimtex_view_method = "skim"
      vim.g.vimtex_view_general_viewer = "/Applications/Skim.app/Contents/SharedSupport/displayline"
      vim.g.vimtex_view_general_options = "-r @line @pdf @tex"

      -- === jj 快捷键：插入模式下退出 Normal 模式并保存 ===
      vim.api.nvim_set_keymap("i", "jj", "<Esc>:w<CR>", { noremap = true, silent = true })

      -- === 自动保存后触发编译 ===
      vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = "*.tex",
        callback = function()
          -- 保存后自动编译
          vim.cmd("VimtexCompile")
        end,
      })
    end,
  },
}
