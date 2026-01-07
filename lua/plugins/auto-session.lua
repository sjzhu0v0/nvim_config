return {
  "rmagatti/auto-session",
  lazy = false, -- 必须立刻加载
  config = function()
    vim.opt.sessionoptions = {
      "buffers",
      "curdir",
      "tabpages",
      "winsize",
      "help",
      "globals",
    }

    require("auto-session").setup({
      auto_save_enabled = true,
      auto_restore_enabled = true,

      -- 忽略这些目录
      suppressed_dirs = {
        "~",
        "~/Downloads",
        "/tmp",
      },

      -- Telescope 集成（LazyVim 默认有）
      session_lens = {
        load_on_setup = true,
        theme_conf = { border = true },
      },
    })

  end,
}

