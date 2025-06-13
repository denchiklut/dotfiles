require "nvchad.options"

vim.api.nvim_create_autocmd("BufReadPost", {
  once = true,
  callback = function()
    local mason_flag = vim.fn.stdpath "data" .. "/mason_installed"

    if vim.fn.empty(vim.fn.glob(mason_flag)) > 0 then
      vim.schedule(function()
        vim.cmd "MasonInstallAll"
        vim.fn.writefile({}, mason_flag)
      end)
    end
  end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "*",
  callback = function()
    if vim.bo.filetype == "codecompanion" then
      vim.wo.number = false
      vim.wo.relativenumber = false
      vim.b.completion = false
    end
  end,
})

vim.api.nvim_create_autocmd("BufDelete", {
  callback = function()
    local bufs = vim.t.bufs
    if #bufs == 1 and vim.api.nvim_buf_get_name(bufs[1]) == "" then
      vim.cmd "Nvdash"
    end
  end,
})

-- Workaround for truncating long TypeScript inlay hints.
-- TODO: Remove this if https://github.com/neovim/neovim/issues/27240 gets addressed.
local methods = vim.lsp.protocol.Methods
local inlay_hint_handler = vim.lsp.handlers[methods.textDocument_inlayHint]

vim.lsp.handlers[methods.textDocument_inlayHint] = function(err, result, ctx, config)
  local client = vim.lsp.get_client_by_id(ctx.client_id)
  if client and client.name == "typescript-tools" and type(result) == "table" then
    result = vim.tbl_map(function(hint)
      local label = hint.label
      if type(label) == "string" and #label > 30 then
        label = label:sub(1, 29) .. "..."
      end

      hint.label = label
      return hint
    end, result)
  end

  inlay_hint_handler(err, result, ctx, config)
end
