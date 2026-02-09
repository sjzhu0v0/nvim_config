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

-- vim.g.clipboard = {
--   name = 'win32yank',
--   copy = {
--     ['+'] = 'win32yank.exe -i --crlf',
--     ['*'] = 'win32yank.exe -i --crlf',
--   },
--   paste = {
--     ['+'] = 'win32yank.exe -o --lf',
--     ['*'] = 'win32yank.exe -o --lf',
--   },
--   cache_enabled = 0,
-- }

vim.g.clipboard = {
  name = 'xclip',
  copy = {
    ['+'] = 'xclip -selection clipboard',
    ['*'] = 'xclip -selection primary',
  },
  paste = {
    ['+'] = 'xclip -selection clipboard -o | perl -pe \'chomp if eof\'',
    ['*'] = 'xclip -selection primary -o | perl -pe \'chomp if eof\'',
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
 -- {
 --   "github/copilot.vim",
 -- },
 {
   "subnut/nvim-ghost.nvim"
 },
  require("plugins/telescope"),
  require("plugins/lualine"),
  require("plugins/neo-tree"),
  require("plugins/auto-session"),
  require("plugins/tree-sitter"),
  -- require("plugins/bufferline"),
  require("plugins/conform"),
  require("plugins/avante"),
  -- require("plugins/cmp"),
  -- {
  --   "numToStr/Comment.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     require("Comment").setup()
  --   end,
  -- },
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "ltex",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
  },
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

-- 自动在 terminal buffer 调整大小时发送 SIGWINCH
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    vim.opt_local.signcolumn = "no"
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
})

-- require("ghosttext_ltex").setup {
--   shadow_file = "~/content.txt",
--   filetype = "markdown",
-- }


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

-- Still need to use vim.cmd for cabbrev
vim.cmd.cnoreabbrev('vsb vertical sbuffer')
vim.cmd.cnoreabbrev('sb sbuffer')


vim.lsp.enable('pyright')
vim.lsp.enable('clangd')
vim.lsp.enable('pylsp')

-- LSP 快捷键设置示例
local opts = { noremap = true, silent = true }
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
vim.keymap.set('n', 'gD', vim.lsp.buf.type_definition, opts)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
vim.keymap.set('n', '<F1>', vim.lsp.buf.hover, opts)

-- 诊断导航
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts)

vim.lsp.config("ltex", {
  cmd = { "ltex-ls" },

  autostart = true, -- ⭐手动开关

  settings = {
    ltex = {
      language = "en-US",
      checkFrequency = "edit",

      additionalRules = {
        enablePickyRules = true,
      },

      completionEnabled = true,

      latex = {
        environments = {
          "equation",
          "align",
          "gather",
          "multline",
          "eqnarray",
          "split",
        },
      },

      dictionary = {
        ["en-US"] = {
          "QGP", "hydrodynamics", "anisotropic",
          "multiplicity", "pseudorapidity",
          "CMS", "ATLAS", "ALICE", "LHC",
          "PbPb", "pPb", "pp",
        },
      },
    },
  },
})

-- 使用 silent! 的完整版本
vim.keymap.set('n', '<leader>bo', '<cmd>silent! %bd|e#<CR>', {
  desc = 'Close all other buffers',
  noremap = true,
  silent = true,
})
