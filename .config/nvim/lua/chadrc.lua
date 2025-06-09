-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "catppuccin",
}

M.nvdash = {
  load_on_startup = true,
}

M.lsp = {
  signature = false,
}

M.ui = {
  cmp = {
    style = "atom_colored",
  },
}

return M
