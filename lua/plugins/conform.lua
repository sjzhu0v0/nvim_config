return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      -- C / C++
      c = { "clang_format" },
      cpp = { "clang_format" },
      objc = { "clang_format" },
      cuda = { "clang_format" },

      -- Lua
      lua = { "stylua" },

      -- Python
      python = { "black" },

      -- Web
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
      json = { "prettier" },
      yaml = { "prettier" },
      html = { "prettier" },
      css = { "prettier" },

      -- Go / Rust
      go = { "gofmt" },
      rust = { "rustfmt" },

      -- Shell
      sh = { "shfmt" },

      -- Markdown
      markdown = { "prettier" },
    },

    format_on_save = {
      timeout_ms = 1000,
      lsp_fallback = true,
    },
  },
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format()
      end,
      mode = "n",
      desc = "Format buffer",
    },
    {
      "<leader>f",
      function()
        require("conform").format({ mode = "v" })
      end,
      mode = "v",
      desc = "Format selection",
    },
  },
}
