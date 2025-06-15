local M = {}
M.__index = M

function M.new(context, ns)
  return setmetatable({
    bufnr = context.bufnr,
    start_line = context.start_line,
    end_line = context.end_line,
    ns = ns,
  }, M)
end

function M:start()
  local function set_extmark(line_num, sign_text)
    vim.api.nvim_buf_set_extmark(self.bufnr, self.ns, line_num - 1, 0, {
      sign_hl_group = "DiagnosticVirtualTextWarn",
      sign_text = sign_text,
      priority = 2048,
    })
  end

  if self.start_line == self.end_line then
    return set_extmark(self.start_line, "")
  end

  set_extmark(self.start_line, "┌")

  for i = self.start_line + 1, self.end_line - 1 do
    set_extmark(i, "│")
  end

  if self.end_line > self.start_line then
    set_extmark(self.end_line, "└")
  end
end

function M:stop()
  vim.api.nvim_buf_clear_namespace(self.bufnr, self.ns, 0, -1)
end

return M
