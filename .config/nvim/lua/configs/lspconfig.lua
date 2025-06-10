require("nvchad.configs.lspconfig").defaults()

local servers = { "eslint", "html", "cssls", "bashls" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
