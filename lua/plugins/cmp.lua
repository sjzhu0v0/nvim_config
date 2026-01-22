return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "neovim/nvim-lspconfig",
  },
  config = function()
    local cmp = require("cmp")

    -- 配置 nvim-cmp
    cmp.setup({
      snippet = {
        expand = function(args)
          vim.fn["vsnip#anonymous"](args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        -- ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        -- ["<C-f>"] = cmp.mapping.scroll_docs(4),
        -- ["<C-Space>"] = cmp.mapping.complete(),
        -- ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },     -- LSP 补全
        { name = "buffer" },       -- 当前 buffer
        { name = "path" },         -- 路径
      }),
    })

    -- 设置 LSP 服务器（以 pyright 为例）
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    -- lspconfig.pyright.setup({
    --   capabilities = capabilities,
    -- })
    -- 可添加更多语言服务器...
  end,
}
