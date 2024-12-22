-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps herea
local map = vim.keymap.set
-- local opts = { noremap = true, silent = true }

map("n", "<leader>p", '<cmd>lua require("cmp").setup { enabled = true }<cr>', { desc = "Enable completion" })
map(
	"n",
	"<leader>P",
	'<cmd>lua require("cmp").setup { enabled = false }<cr>',
	{ desc = "Disable completion" }
)
-- lsp
map("n", "<leader>S", "<cmd>LspStop<CR>", { desc = "LspStop" })

-- surrounding words
map("n", "<leader>wsq", 'ciw""<Esc>P', { desc = "Word Surround Quotes" })

-- replaces
map("n", "<leader>rbs", "<cmd>%s/\\//g<CR>", { desc = "Replace Backward Slash" })

-- telescope symbols
map("n", "<leader>fs", "<cmd>Telescope symbols<cr>", { desc = "Find Symbols" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Find Grep" })

-- convert Current line to title cases
map(
	"n",
	"<leader>rlt",
	"<cmd>lua require('textcase').current_word('to_title_case')<CR>",
	{ desc = "Replace Line Title" }
)

-- these keep the cursor in the middle when scrolling with ctrl d and u
-- from https://github.com/ThePrimeagen/init.lua
-- map("n", "<C-d>", "<C-d>zz")
-- map("n", "<C-u>", "<C-u>zz")

-- window management
map("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })   -- split window vertically
map("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally

-- Increment/decrement
map("n", "+", "<C-a>")
map("n", "-", "<C-x>")

-- Delete a word backwards
map("n", "dw", 'vb"_d')


-- New tab
map("n", "te", ":tabedit")
map("n", "<tab>", ":tabnext<Return>")
map("n", "<s-tab>", ":tabprev<Return>")

-- Split window
map("n", "ss", ":split<Return>")
map("n", "sv", ":vsplit<Return>")
-- Move window
map("n", "sh", "<C-w>h")
map("n", "sk", "<C-w>k")
map("n", "sj", "<C-w>j")
map("n", "sl", "<C-w>l")

map('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
	expr = true,
	replace_keycodes = false
})
-- vim.g.copilot_no_tab_map = true

map('n', '<leader><u>', vim.cmd.UndotreeToggle)

map("n", "<C-J>", ":bprevious<CR>", { desc = "Previous buffer" })
map("n", "<C-K>", ":bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bd", ":bd<CR>", { desc = "Delete buffer" })

-- map esc to jk for laptop use
map("i", "jk", "<Esc>", { desc = "Escape jk" })
