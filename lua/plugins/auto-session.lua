return {
  "rmagatti/auto-session",
  lazy = false,
  config = function()
    vim.opt.sessionoptions = {
      "buffers",
      "curdir",
      "tabpages",
      "winsize",
      "help",
      "globals",
    }

    -- ✅ 关键：检测是否通过 +cmd / -c 启动，若是则跳过自动恢复
    local should_auto_restore = true

    -- 检查是否有非 help 的 buffer 已存在（说明可能是命令行启动）
    -- 或者检查 v:argv 是否包含 '+' 或 '-c'
    for _, arg in ipairs(vim.v.argv) do
      if arg == "+" or arg:sub(1, 2) == "+:" or arg == "-c" then
        should_auto_restore = false
        break
      end
    end

    require("auto-session").setup({
      auto_save_enabled = true,
      auto_restore_enabled = should_auto_restore, -- 👈 动态控制
      suppressed_dirs = {
        "~",
        "~/Downloads",
        "/tmp",
      },
      session_lens = {
        load_on_setup = true,
        theme_conf = { border = true },
      },
    })
  end,
}
