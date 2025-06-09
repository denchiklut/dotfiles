local M = {}
M.__index = M

function M.new(context, ns)
  local lines = vim.api.nvim_buf_get_lines(context.bufnr, context.start_line - 1, context.end_line, false)
  local width = vim.fn.max(vim
    .iter(lines)
    :map(function(line)
      return vim.fn.strdisplaywidth(line)
    end)
    :totable())

  local patterns = {}
  local raw_patterns = {
    "╲  ",
    " ╲ ",
    "  ╲",
  }

  local pattern_width = vim.fn.strdisplaywidth(raw_patterns[1])
  local repetitions = pattern_width > 0 and math.ceil(width / pattern_width) or width
  local horizontal_line = string.rep("─", repetitions * pattern_width)

  for _, pattern in ipairs(raw_patterns) do
    table.insert(patterns, string.rep(pattern, repetitions))
  end

  return setmetatable({
    bufnr = context.bufnr,
    ns = ns,
    start_line = context.start_line - 1,
    end_line = context.end_line - 1,
    ids = {},
    patterns = patterns,
    current_index = 1,
    timer = vim.uv.new_timer(),
    width = width,
    height = #lines,
    border_top = "╭" .. horizontal_line .. "╮",
    border_bottom = "╰" .. horizontal_line .. "╯",
  }, M)
end

function M:get_virtual_text(i)
  local pattern_index = ((i + self.current_index - 1) % #self.patterns) + 1
  local pattern = self.patterns[pattern_index]

  if self.height <= 2 then
    return { { pattern, "Comment" } }
  end

  if i == self.start_line then
    return { { self.border_top, "Comment" } }
  end

  if i == self.end_line then
    return { { self.border_bottom, "Comment" } }
  end

  return { { "│" .. pattern .. "│", "Comment" } }
end

function M:write_extmarks(start, pos, id)
  return vim.api.nvim_buf_set_extmark(self.bufnr, self.ns, start, 0, {
    virt_text = self:get_virtual_text(pos or start),
    virt_text_repeat_linebreak = true,
    virt_text_pos = "overlay",
    priority = 2048,
    id = id,
  })
end

function M:set_new_extmarks()
  self.ids = {}

  for i = self.start_line, self.end_line do
    self.ids[i] = self:write_extmarks(i)
  end
end

function M:animate_extmarks()
  for i, id in pairs(self.ids) do
    local current_pos = vim.api.nvim_buf_get_extmark_by_id(self.bufnr, self.ns, id, {})

    pcall(function()
      self:write_extmarks(current_pos[1], i, id)
    end)
  end
end

function M:start()
  self:set_new_extmarks()

  self.timer:start(
    0,
    100,
    vim.schedule_wrap(function()
      self.current_index = (self.current_index % #self.patterns) + 1
      self:animate_extmarks()
    end)
  )
end

function M:stop()
  if self.timer then
    self.timer:stop()
    self.timer:close()
    self.timer = nil
  end

  for _, id in pairs(self.ids) do
    vim.schedule(function()
      vim.api.nvim_buf_del_extmark(self.bufnr, self.ns, id)
    end)
  end
end

return M
