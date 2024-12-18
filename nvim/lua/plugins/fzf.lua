return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- calling `setup` is optional for customization
    require("fzf-lua").setup({
      winopts = {
        preview = {
          wrap = "wrap",
        },
        width = 0.8,
        height = 0.8,
        row = 0.5,
        col = 0.5,
      },
      defaults = {
        -- git_icons = false,
        -- file_icons = false,
        -- color_icons = false,
        -- formatter = "path.filename_first",
      },
    })
  end
}
