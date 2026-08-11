-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt

-- try this: vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
--

opt.ignorecase = true

-- pandoc related

opt.spell = false
opt.foldmethod = "manual"
opt.foldenable = false

-- clipboard
vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard

-- scrolling
opt.number = true
opt.relativenumber = false
opt.scrolloff = 8
opt.textwidth = 80
opt.linebreak = true
vim.g.snacks_animate = false

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive
opt.wrap = false -- don't wrap search
opt.cursorline = true
--
vim.g.mkdp_browser = "/Applications/Arc.app/Contents/MacOS/Arc"
