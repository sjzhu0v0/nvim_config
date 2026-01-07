-- 搜索高亮
vim.opt.hlsearch = true

-- 全局缩进设置
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- 退格行为
vim.opt.backspace = { "indent", "eol", "start" }

-- 鼠标
vim.opt.mouse = "a"

-- 启用文件类型检测
vim.cmd("filetype plugin indent on")

