local map = vim.keymap.set

-- 保存 / 退出
map("n", "<C-s>", ":w<CR>")
map("n", "<C-q>", ":q<CR>")

-- 窗口缩放
map("n", "<S-Up>", ":resize -1<CR>")
map("n", "<S-Down>", ":resize +1<CR>")
map("n", "<S-Left>", ":vertical resize -1<CR>")
map("n", "<S-Right>", ":vertical resize +1<CR>")

-- 选择
map("n", "<leader>sa", "ggVG")
map("n", "<leader>se", "VG")
map("n", "<leader>ss", "Vgg")

