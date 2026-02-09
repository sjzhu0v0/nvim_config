return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree",
  keys = {
    { "<C-e>", "<cmd>Neotree toggle<CR>", desc = "Toggle file tree" },
    { "<leader>dg", "<cmd>Neotree git_status toggle<CR>", desc = "Git status" },
    { "<leader>db", "<cmd>Neotree buffers toggle<CR>", desc = "Buffers" },
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,

      default_component_configs = {
        indent = {
          indent_size = 2,
          padding = 1,
          with_markers = true,
        },
        icon = {
          folder_closed = "+",
          folder_open = "-",
          folder_empty = ".",
        },
        git_status = {
          symbols = {
            added     = "A",
            modified  = "M",
            deleted   = "D",
            renamed   = "R",
            untracked = "?",
            ignored   = "I",
            unstaged  = "U",
            staged    = "S",
            conflict  = "C",
          },
        },
      },
      window = {
        position = "left",
        width = 30,
        mappings = {
          ["<CR>"] = "open",
          ["v"] = "open_vsplit",
          ["s"] = "open_split",
          ["t"] = "open_tabnew",
          ["q"] = "close_window",
          ["H"] = "toggle_hidden",
          ["R"] = "refresh",
          ["a"] = "add",
          ["d"] = "delete",
          ["r"] = "rename",
          ["C"] = "set_root",
          ["U"] = "navigate_up",
          ["P"] = function(state)
            local node = state.tree:get_node()
            vim.fn.jobstart({ "xdg-open", node:get_id() }, { detach = true })
          end
        },
      },

      filesystem = {
        follow_current_file = { enabled = true },
        hijack_netrw_behavior = "open_default",
        use_libuv_file_watcher = true,
      },
    })
  end,
}

