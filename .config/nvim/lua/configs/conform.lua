local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "biome" },
    scss = { "prettier" },
    html = { "prettier" },
    javascript = { "biome" },
    javascriptreact = { "biome" },
    typescript = { "biome" },
    typescriptreact = { "biome" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
