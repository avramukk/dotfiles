return {
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require'cmp'
      cmp.setup({
        completion = {
          autocomplete = false,  -- Вимикає автоматичне автозавершення
        },
        -- Інші налаштування...
      })
    end,
  },
}
