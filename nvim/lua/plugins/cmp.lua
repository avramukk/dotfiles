return {
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require'cmp'
      cmp.setup({
        completion = {
          autocomplete = true,  -- Вимикає автоматичне автозавершення
        },
        -- Інші налаштування...
      })
    end,
  },
}
