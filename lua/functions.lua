-- ===============================
-- 交互式替换（支持当前行 / 选区）
-- ===============================
function ReplacePrompt()
  local a = vim.fn.input("2_b_replaced: ")
  local b = vim.fn.input("replace_2: ")

  if a == "" then
    return
  end

  -- 正确的 escape 写法（Lua 字符串）
  local pat = vim.fn.escape(a, "\\/.*$^~[]")
  local rep = vim.fn.escape(b, "\\/&")

  -- 如果是可视模式，用选区；否则用当前行
  local mode = vim.fn.mode()
  if mode == "v" or mode == "V" then
    local range = vim.fn.line("'<") .. "," .. vim.fn.line("'>")
    vim.cmd(range .. "s/" .. pat .. "/" .. rep .. "/g")
  else
    vim.cmd("s/" .. pat .. "/" .. rep .. "/g")
  end
end

-- Normal / Visual 模式映射
vim.keymap.set("n", "<leader>er", ReplacePrompt)
vim.keymap.set("v", "<leader>er", ReplacePrompt)


-- 切换鼠标开关
function _G.toggle_mouse()
  if vim.o.mouse == "" then
    vim.o.mouse = "a"
    print("🐭 Mouse enabled")
  else
    vim.o.mouse = ""
    print("🐭 Mouse disabled")
  end
end

-- 快捷键：<leader>m
vim.keymap.set("n", "<leader>m", toggle_mouse, { desc = "Toggle mouse" })

