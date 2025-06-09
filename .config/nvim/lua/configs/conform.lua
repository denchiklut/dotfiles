local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    scss = { "prettier" },
    html = { "prettier" },
    javascript = { "prettier", "eslint" },
    javascriptreact = { "prettier", "eslint" },
    typescript = { "prettier", "eslint" },
    typescriptreact = { "prettier", "eslint" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
