local autocmd = vim.api.nvim_create_autocmd

-- Makefile 必须用 Tab
autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "[Mm]akefile*",
  callback = function()
    vim.opt_local.expandtab = false
  end,
})

-- Python
autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})

-- C / C++
autocmd("FileType", {
  pattern = { "c", "cpp" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})

-- Go
autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 4
  end,
})

-- Markdown
autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.conceallevel = 2
  end,
})

