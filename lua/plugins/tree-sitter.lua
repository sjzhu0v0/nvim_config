return {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- Last release is way too old
    build = ":TSUpdate",
    -- event = { "BufReadPost", "BufNewFile" },
    lazy = false, -- Keep false to ensure loading for Neo-tree
    main = "nvim-treesitter.configs", -- Lazy handles the require logic here
    branch = "master", -- Explicitly force the stable branch
}
