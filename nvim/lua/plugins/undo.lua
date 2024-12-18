return { 'mbbill/undotree',
  setup = function()
    vim.g.undotree_WindowLayout = 2
    vim.g.undotree_SetFocusWhenToggle = 1
    vim.g.undotree_SplitWidth = 50
    vim.g.undotree_SplitMinWidth = 50
    vim.g.undotree_SplitRight = 1
    vim.g.undotree_HighlightChangedWithSign = 1
    vim.g.undotree_HighlightChangedWithText = 1
  end,
  keys ={
    { '<leader>u', '<cmd>UndotreeToggle<CR>', desc = 'Toggle Undotree' },
  }
}
