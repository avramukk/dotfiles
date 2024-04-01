return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        pyright = {},
        bashls = {},
        bicep = {},
        yamlls = {},
        marksman = {},
        powershell_es = {},
        terraformls = {},
        helm_ls = {},
        jsonls = {},
        html = {},
        cssls = {},
      },
    },
  },
}
