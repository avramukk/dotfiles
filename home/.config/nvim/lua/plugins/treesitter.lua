return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      local treesitter = require("nvim-treesitter")
      local install = treesitter.install

      treesitter.install = function(languages, options)
        if options then
          options = vim.tbl_extend("force", {}, options, { summary = false })
        end
        return install(languages, options)
      end

      opts.indent = { enable = true }
      opts.highlight = { enable = true }
      opts.folds = { enable = true }
      opts.ensure_installed = {
        "bash",
        "c",
        "diff",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "printf",
        "python",
        "query",
        "regex",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      }
      return opts
    end,
  },
}
