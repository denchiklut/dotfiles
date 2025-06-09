local M = {}
M.__index = M

function M.get_buf(filetype)
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].filetype == filetype then
      return buf
    end
  end

  return nil
end

function M.new()
  return setmetatable({
    current_index = 1,
    processing = false,
    bufnr = M.get_buf "codecompanion",
    timer = vim.uv.new_timer(),
    spinner_symbols = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
    ns = vim.api.nvim_create_namespace "CodeCompanionSpinner",
  }, M)
end

function M:start()
  self.processing = true
  self.current_index = 0

  if not self.bufnr then
    return
  end

  self.timer:start(
    0,
    100,
    vim.schedule_wrap(function()
      self.current_index = (self.current_index % #self.spinner_symbols) + 1
      vim.api.nvim_buf_clear_namespace(self.bufnr, self.ns, 0, -1)
      local last_line = vim.api.nvim_buf_line_count(self.bufnr) - 1

      vim.api.nvim_buf_set_extmark(self.bufnr, self.ns, last_line, 0, {
        virt_lines = { { { self.spinner_symbols[self.current_index] .. "   Processing", "Comment" } } },
        virt_lines_above = true,
      })
    end)
  )
end

function M:stop()
  self.processing = false

  if self.timer then
    self.timer:stop()
    self.timer:close()
    self.timer = nil
  end

  if self.bufnr then
    vim.api.nvim_buf_clear_namespace(self.bufnr, self.ns, 0, -1)
  end
end

return M
