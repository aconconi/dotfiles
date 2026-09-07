-- Custom key bindings

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- File Explorer (NvimTree)
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Telescope (fuzzy finder)
keymap("n", "<leader>ff", function() require("telescope.builtin").git_files() end, opts)
keymap("n", "<leader>fa", function() require("telescope.builtin").find_files() end, opts)
keymap("n", "<leader>fg", function() require("telescope.builtin").live_grep() end, opts)
keymap("n", "<leader>fb", function() require("telescope.builtin").buffers() end, opts)

