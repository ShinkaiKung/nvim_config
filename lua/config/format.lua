-- 自动格式化
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    -- 如果 lsp 支持格式化，则执行
    vim.lsp.buf.format({
      async = false,
      timeout_ms = 2000, -- 可选，格式化超时时间
    })
  end,
})
