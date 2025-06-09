local M = {}

M.heading_fg = {
  "#89b4fa",
  "#cba6f7",
  "#a6e3a1",
  "#74c7ec",
  "#fab387",
  "#f5c2e7",
}

M.heading_bg = {
  "#23273a",
  "#2b2640",
  "#252c2c",
  "#182931",
  "#2d282c",
  "#352a36",
}

-- Set heading highlights
function M.set_headings()
  for i = 1, 6 do
    local ts_group = "@markup.heading." .. i .. ".markdown"
    local render_bg_group = "RenderMarkdownH" .. i .. "Bg"

    vim.api.nvim_set_hl(0, ts_group, {
      fg = M.heading_fg[i],
      bold = true,
    })

    vim.api.nvim_set_hl(0, render_bg_group, {
      fg = M.heading_fg[i],
      bg = M.heading_bg[i],
    })
  end
end

-- Set generic markdown highlights
function M.set_markdown()
  local highlights = {
    { "@markup.list.markdown", "#fab387" },
    { "RenderMarkdownBullet", "#fab387" },
    { "RenderMarkdownUnchecked", "#89b4fa" },
    { "@markup.list.unchecked.markdown", "#89b4fa" },
    { "RenderMarkdownChecked", "#a6e3a1" },
    { "@markup.list.checked.markdown", "#a6e3a1" },
    { "@markup.link.markdown_inline", "#fab387" },
    { "@markup.link.label.markdown_inline", "#fab387" },
    { "RenderMarkdownTodo", "#fab387" },
  }

  for _, hl in ipairs(highlights) do
    vim.api.nvim_set_hl(0, hl[1], { fg = hl[2], bold = true })
  end
end

-- Set yank highlight
function M.set_yank_highlight()
  vim.api.nvim_set_hl(0, "YankHighlight", { bg = "#fab387", fg = "#1e1e2e" })
  vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
      vim.highlight.on_yank { higroup = "YankHighlight", timeout = 150 }
    end,
  })
end

-- Run all highlight setups
function M.setup()
  M.set_headings()
  M.set_markdown()
  M.set_yank_highlight()
end

return M
