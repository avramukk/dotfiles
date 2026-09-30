return {
  "mfussenegger/nvim-lint",
  config = function()
    local lint = require("lint")
    -- The markdown extra would lint markdown with markdownlint-cli2,
    -- which we deliberately don't install. Clear it so nvim-lint stops
    -- trying to run a missing binary on every markdown buffer.
    lint.linters_by_ft = vim.tbl_deep_extend("force", lint.linters_by_ft or {}, {
      markdown = {},
    })
  end,
}