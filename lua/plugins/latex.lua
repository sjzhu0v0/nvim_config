return {

  --------------------------------------------------
  -- vimtex（LaTeX 核心）
  --------------------------------------------------
  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      -- 编译方式
      vim.g.vimtex_compiler_method = "latexmk"

      -- PDF 查看器
      vim.g.vimtex_view_method = "general"
      -- vim.g.vimtex_view_method = "general"

      -- - SumatraPDF 绝对路径（‼ 必改为你的路径）
      vim.g.vimtex_view_general_viewer =
        "D:/SumatraPDF/SumatraPDF.exe"

      -- 正向搜索参数
      vim.g.vimtex_view_general_options =
        "-reuse-instance -forward-search @tex @line @pdf"

      -- latexmk 参数
      vim.g.vimtex_compiler_latexmk = {
        continuous = 0,
        options = {
          "-pdf",
          "-interaction=nonstopmode",
          "-synctex=1",
        },
      }

      -- 使用 nvim-cmp，不用 vimtex 自带补全
      vim.g.vimtex_complete_enabled = 0
    end,
  },

  --------------------------------------------------
  -- LSP：texlab
  --------------------------------------------------
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      lspconfig.texlab.setup({
        settings = {
          texlab = {
            build = {
              executable = "latexmk",
              onSave = true,
            },
            forwardSearch = {
              executable =
                "C:/Program Files/SumatraPDF/SumatraPDF.exe",
              args = {
                "-reuse-instance",
                "-forward-search",
                "%f",
                "%l",
                "%p",
              },
            },
          },
        },
      })
    end,
  },

  --------------------------------------------------
  -- nvim-cmp（补全）
  --------------------------------------------------
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        },
      })
    end,
  },

  --------------------------------------------------
  -- 拼写检查（Neovim 内置）
  --------------------------------------------------
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "tex", "plaintex", "latex" },
        callback = function()
          vim.opt_local.spell = true
          vim.opt_local.spelllang = { "en_us" }
        end,
      })
    end,
  },
}

