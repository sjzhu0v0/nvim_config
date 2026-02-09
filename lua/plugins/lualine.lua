return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- 可选：图标
  },
  config = function()
    require("lualine").setup({
      options = {
        theme = "auto",
        globalstatus = true, -- 推荐：一条全局状态栏
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff" },
        lualine_c = { "filename" },

        lualine_x = { "encoding", "filetype" },
        lualine_y = { "progress" },
        lualine_z = {
          function()
            return os.date("%H:%M")
          end,
        },
      },
    })
  end,
}

