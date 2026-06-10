local M = {}

M.setup = function()
  local map = vim.keymap.set
  local oc = require "opencode"

  map({ "n", "v" }, "<C-a>", oc.select, { desc = "Execute opencode action…" })
  map({ "n", "v" }, "<leader>aa", oc.ask, { desc = "Ask opencode" })
  map("v", "<leader>ai", function()
    oc.ask "@this "
  end, { desc = "Opencode chat with selection" })
end

return M
