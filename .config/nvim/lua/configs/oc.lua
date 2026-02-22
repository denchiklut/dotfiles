local M = {}

M.setup = function()
  local map = vim.keymap.set
  local oc = require "opencode"

  map({ "n", "v" }, "<C-a>", oc.select, { desc = "Execute opencode action…" })
  map({ "n", "v" }, "<leader>aa", oc.toggle, { desc = "Open opencode" })
  map("v", "<leader>ai", function()
    local ctx = require("opencode.context").new()
    oc.prompt("@this ", { context = ctx, submit = false })
    oc.start()
  end, { desc = "Opencode chat with selection" })
end

return M
