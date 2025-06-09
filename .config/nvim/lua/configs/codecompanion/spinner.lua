local M = {}
M.__index = M

function M.new(context, ns, width)
  local spinner_text = "  Processing"
  local width_center = width - spinner_text:len()
  local col = width_center > 0 and math.floor(width_center / 2) or 0

  return setmetatable({
    bufnr = context.bufnr,
    ns = ns,
    line_num = context.start_line + math.floor((context.end_line - context.start_line) / 2) - 1,
    current_index = 1,
    timer = vim.uv.new_timer(),
    spinner_text = spinner_text,
    spinner_frames = { "⣷", "⣯", "⣟", "⡿", "⢿", "⣻", "⣽", "⣾" },
    extmark = {
      virt_text_win_col = col,
      virt_text_pos = "overlay",
      priority = 2049,
    },
  }, M)
end

function M:get_virtual_text()
  return {
    {
      self.spinner_text .. " " .. self.spinner_frames[self.current_index] .. " ",
      "DiagnosticVirtualTextWarn",
    },
  }
end

function M:set_extmark()
  return vim.api.nvim_buf_set_extmark(self.bufnr, self.ns, self.line_num, 0, self.extmark)
end

function M:start()
  self.extmark.virt_text = self:get_virtual_text()
  self.extmark.id = self:set_extmark()

  self.timer:start(
    0,
    100,
    vim.schedule_wrap(function()
      self.current_index = self.current_index % #self.spinner_frames + 1
      self.extmark.virt_text = self:get_virtual_text()
      self:set_extmark()
    end)
  )
end

function M:stop()
  if self.timer then
    self.timer:stop()
    self.timer:close()
    self.timer = nil
  end

  vim.schedule(function()
    vim.api.nvim_buf_del_extmark(self.bufnr, self.ns, self.extmark.id)
  end)
end

return M
