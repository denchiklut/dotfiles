local M = {}

M.heading_fg = {
  "#89b4fa",
  "#cba6f7",
  "#74c7ec",
  "#a6e3a1",
  "#fab387",
  "#f5c2e7",
}

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
    })
  end
end

function M.set_markdown()
  local highlights = {
    { "@markup.list.markdown", "#89b4fa" },
    { "RenderMarkdownBullet", "#89b4fa" },
    { "RenderMarkdownUnchecked", "#89b4fa" },
    { "@markup.list.unchecked.markdown", "#89b4fa" },
    { "@markup.raw.markdown_inline", "#a6e3a1" },
    { "RenderMarkdownChecked", "#a6e3a1" },
    { "@markup.list.checked.markdown", "#a6e3a1" },
    { "@markup.link.markdown_inline", "#fab387" },
    { "@markup.link.label.markdown_inline", "#fab387" },
    { "@markup.strong", "#fab387" },
    { "RenderMarkdownTodo", "#fab387" },
  }

  for _, hl in ipairs(highlights) do
    vim.api.nvim_set_hl(0, hl[1], { fg = hl[2], bold = true })
  end
end

function M.set_yank_highlight()
  vim.api.nvim_set_hl(0, "YankHighlight", { bg = "#fab387", fg = "#1e1e2e" })
  vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
      vim.highlight.on_yank { higroup = "YankHighlight", timeout = 150 }
    end,
  })
end

function M.setup()
  M.set_headings()
  M.set_markdown()
  M.set_yank_highlight()
end

return M
