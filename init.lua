require("options")
require("keymaps")
require("autocmds")
require("functions")

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.clipboard = "unnamedplus"  -- 将默认寄存器映射到系统剪贴板
vim.keymap.set("n", "gp", "`[v`]", { desc = "Select last pasted text" })


vim.api.nvim_create_user_command("Scratch", function(opts)
  vim.cmd("enew")
  vim.bo.buftype = "nofile"
  vim.bo.bufhidden = "wipe"
  vim.bo.swapfile = false
  if opts.args ~= "" then
    vim.bo.filetype = opts.args
  end
end, { nargs = "?" })



-- 设置 provider（如果 Neovim 没有自动识别）
vim.g.clipboard = {
  name = 'win32yank',
  copy = {
    ['+'] = 'win32yank.exe -i --crlf',
    ['*'] = 'win32yank.exe -i --crlf',
  },
  paste = {
    ['+'] = 'win32yank.exe -o --lf',
    ['*'] = 'win32yank.exe -o --lf',
  },
  cache_enabled = 0,
}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- 如果不存在就自动 clone
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

-- 提前加入 runtimepath
vim.opt.rtp:prepend(lazypath)

-- 启动 lazy.nvim
require("lazy").setup({
  {
    "github/copilot.vim",
  },
  require("plugins/telescope"),
  require("plugins/neo-tree"),
  require("plugins/auto-session"),
  require("plugins/tree-sitter"),
  require("plugins/conform"),
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'c' , 'cpp' , 'python' , 'yaml' , 'json' },
  callback = function() vim.treesitter.start() end,
})

require("nvim-treesitter.configs").setup({
  -- 安装的语言解析器
  ensure_installed = {
    "lua",
    "vim",
    "vimdoc",
    "bash",
    "c",
    "cpp",
    "python",
    "javascript",
    "typescript",
    "html",
    "css",
    "json",
    "markdown",
  },

  -- 自动安装缺失的 parser
  auto_install = true,

  highlight = {
    enable = true,        -- 启用 Treesitter 高亮
  },
})

vim.keymap.set("n", "<leader>f", function()
  require("conform").format({ async = true })
end)

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldlevel = 99

vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

-- 缩进相关设置
vim.opt.tabstop = 2        -- 一个 Tab 显示为 4 个空格
vim.opt.shiftwidth = 2     -- 自动缩进宽度
vim.opt.softtabstop = 2    -- 插入模式 Tab 的空格数
vim.opt.expandtab = true   -- Tab 转空格

-- Map double escape to ensure clean exit (optional)
vim.api.nvim_set_keymap('t', '<Esc><Esc>', '<C-\\><C-n>', {noremap = true})

-- Or if you prefer single Escape but want to ensure it works:
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', {noremap = true})
