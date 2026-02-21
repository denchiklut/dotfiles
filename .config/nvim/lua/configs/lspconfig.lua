require("nvchad.configs.lspconfig").defaults()

local servers = { "biome", "html", "cssls", "bashls" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
