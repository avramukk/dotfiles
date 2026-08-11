-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("config.keymaps")
vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
vim.o.lazyredraw = false
vim.o.ttyfast = true
