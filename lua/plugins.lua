vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/lazy.nvim")

require("lazy").setup({
  -- GitHub Copilot
  {
    "github/copilot.vim",
  },

  -- NERDTree
--  {
--    "preservim/nerdtree",
--    config = function()
--      vim.g.NERDTreeMinimalUI = 1
--      vim.g.NERDTreeDirArrowExpandable = "▸"
--      vim.g.NERDTreeDirArrowCollapsible = "▾"
--      vim.keymap.set("n", "<C-e>", ":NERDTreeToggle<CR>")
--    end,
--  },
  require("neo-tree"),
})

