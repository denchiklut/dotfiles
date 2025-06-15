local M = {}

M.spinners = {}

function M.start_inline_loader(context, ns)
  if vim.tbl_isempty(context) then
    return
  end

  local block = require("configs.codecompanion.block").new(context, ns)
  local spinner = require("configs.codecompanion.spinner").new(context, ns, block.width)
  local signs = require("configs.codecompanion.signs").new(context, ns)

  spinner:start()
  signs:start()
  block:start()

  M.spinners[ns] = { spinner, signs, block }
end

function M.stop_inline_loader(ns)
  local spinner, signs, block = unpack(M.spinners[ns])

  spinner:stop()
  block:stop()
  signs:stop()

  M.spinners[ns] = nil
end

function M.start_chat_loader()
  M.chat = require("configs.codecompanion.chat").new()
  M.chat:start()
end

function M.stop_chat_loader()
  M.chat:stop()
  M.chat = nil
end

function M.setup()
  vim.api.nvim_create_autocmd("User", {
    pattern = "CodeCompanionRequest*",
    group = vim.api.nvim_create_augroup("CodeCompanionHooks", { clear = true }),
    callback = function(request)
      local data = request.data or {}
      local context = data.context or {}
      local ns = vim.api.nvim_create_namespace("CodeCompanionInline_" .. data.id)

      if request.match == "CodeCompanionRequestStarted" then
        M.start_chat_loader()
      elseif request.match == "CodeCompanionRequestFinished" then
        M.stop_chat_loader()
      elseif request.match:find "StartedInline" then
        M.start_inline_loader(context, ns)
      elseif request.match:find "FinishedInline" then
        M.stop_inline_loader(ns)
      end
    end,
  })
end

return M
