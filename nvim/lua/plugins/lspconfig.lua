return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        bashls = {},
        bicep = {},
        yamlls = {},
        dockerls = {},
        -- marksman = {},
        powershell_es = {},
        terraformls = {},
        helm_ls = {},
        jsonls = {},
      -- disable diagnostic by default
      -- on_attach = function(client, bufnr)
      --   require("lua-dev").on_attach(client, bufnr)
      --   require("lsp").on_attach(client, bufnr)
      -- end,
    },
  },
},
}
