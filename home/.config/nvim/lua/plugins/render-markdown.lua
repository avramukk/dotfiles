return {
  "MeanderingProgrammer/render-markdown.nvim",
  opts = {
    code = {
      sign = false,
      width = "block",
      right_pad = 1,
    },
    heading = {
      sign = false,
      icons = {},
    },
    checkbox = {
      enabled = false,
    },
    overrides = {
      filetype = {
        ["mermaid-preview"] = {
          anti_conceal = { enabled = false },
          win_options = {
            concealcursor = { default = "nvic", rendered = "nvic" },
          },
        },
      },
    },
  },
  ft = { "markdown", "norg", "rmd", "org", "codecompanion", "mermaid-preview" },
  config = function(_, opts)
    require("render-markdown").setup(opts)
    Snacks.toggle({
      name = "Render Markdown",
      get = require("render-markdown").get,
      set = require("render-markdown").set,
    }):map("<leader>um")
  end,
}
