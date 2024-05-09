return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        -- pyright = {},
        bashls = {
          autostart = true},
        bicep = {},
        yamlls = {
        autostart = true},
        dockerls = {},
        marksman = {},
        powershell_es = {},
        terraformls = {},
        helm_ls = {},
        jsonls = {},
        html = {},
        cssls = {},
      },
      -- disable diagnostic by default
      on_attach = function(client, bufnr)
        require("lua-dev").on_attach(client, bufnr)
        require("lsp").on_attach(client, bufnr)
      end,
    },
  },
}
