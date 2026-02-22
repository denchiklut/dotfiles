require "nvchad.mappings"
require "configs.teleskope"

local map = vim.keymap.set
local del = vim.keymap.del

local buf = require "configs.buffer"
local volt = require "configs.volt"
local oc = require "configs.oc"

volt.setup()
oc.setup()

del("n", "<leader>h")
map("i", "jj", "<esc>")
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
map("n", ";", ":", { desc = "Enter command mode" })

map("n", "-", "<cmd>Oil<cr>", { desc = "Open parent directory" })
map("n", "<leader>bo", buf.closeOther, { desc = "Close other buffers" })

map("i", "<M-Space>", "copilot#Accept()", { expr = true, replace_keycodes = false, desc = "Copilot: Accept" })
map("i", "<M-c>", "copilot#Dismiss()", { expr = true, replace_keycodes = false, desc = "Copilot: Dismiss" })

map("n", "<leader>gc", ":Neogit commit<cr>", { desc = "Commit changes" })
map("n", "<leader>gp", ":Neogit push<cr>", { desc = "Push changes" })
map("n", "<leader>gP", ":Neogit pull<cr>", { desc = "Pull changes" })

map("n", "<leader>tn", ":tabnext<cr>", { silent = true, desc = "Next tab" })
map("n", "<leader>tp", ":tabprevious<cr>", { silent = true, desc = "Previous tab" })
map("n", "<leader>tt", ":tabnew<cr>", { silent = true, desc = "New tab" })
map("n", "<leader>tx", ":tabclose<cr>", { silent = true, desc = "Close tab" })

map({ "n", "t" }, "<C-h>", "<cmd>TmuxNavigateLeft<cr>", { silent = true })
map({ "n", "t" }, "<C-j>", "<cmd>TmuxNavigateDown<cr>", { silent = true })
map({ "n", "t" }, "<C-k>", "<cmd>TmuxNavigateUp<cr>", { silent = true })
map({ "n", "t" }, "<C-l>", "<cmd>TmuxNavigateRight<cr>", { silent = true })
map({ "n", "t" }, "<C-\\>", "<cmd>TmuxNavigatePrevious<cr>", { silent = true })

map("n", "<leader>gd", ":DiffviewFileHistory %<cr>", { silent = true })
map("n", "<leader>gD", ":DiffviewFileHistory<cr>", { silent = true })
map("n", "<leader>gk", ":DiffviewOpen<cr>", { silent = true })

map("n", "<leader>u", ":TestNearest<cr>", { silent = true })
map("n", "<leader>T", ":TestFile<cr>", { silent = true })
map("n", "<leader>s", ":TestSuite<cr>", { silent = true })
map("n", "<leader>l", ":TestLast<cr>", { silent = true })

map("n", "<leader>ih", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle inlay hints" })

map("n", "<leader>rc", ":source $MYVIMRC<cr>", { desc = "Reload config" })
