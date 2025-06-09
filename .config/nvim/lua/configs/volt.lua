local M = {}

M.setup = function()
  local map = vim.keymap.set

  map({ "n", "v" }, "<C-t>", function()
    require("menu.utils").delete_old_menus()

    local gitsigns = package.loaded.gitsigns
    if gitsigns and gitsigns.get_hunks then
      local bufnr = vim.api.nvim_get_current_buf()
      local hunks = gitsigns.get_hunks(bufnr)
      local line = vim.fn.line "."

      if hunks then
        for _, hunk in ipairs(hunks) do
          if line >= hunk.added.start and line <= (hunk.added.start + hunk.added.count - 1) then
            return require("menu").open "gitsigns"
          end
        end
      end
    end

    if ("#" .. vim.fn.expand "<cword>"):match "^#%x%x%x%x%x%x$" then
      return require("minty.huefy").open()
    end

    require("menu").open "default"
  end)

  map({ "n", "v" }, "<RightMouse>", function()
    require("menu.utils").delete_old_menus()

    vim.cmd [[normal! \<RightMouse>]]

    local pos = vim.fn.getmousepos()
    local winid = pos.winid
    local bufnr = vim.api.nvim_win_get_buf(winid)

    if vim.bo[bufnr].ft == "NvimTree" then
      return require("menu").open("nvimtree", { mouse = true })
    end

    local gitsigns = package.loaded.gitsigns
    if gitsigns and gitsigns.get_hunks then
      local hunks = gitsigns.get_hunks(bufnr)
      if hunks then
        for _, hunk in ipairs(hunks) do
          if pos.line >= hunk.added.start and pos.line <= (hunk.added.start + hunk.added.count - 1) then
            return require("menu").open("gitsigns", { mouse = true })
          end
        end
      end
    end

    local line = vim.api.nvim_buf_get_lines(bufnr, pos.line - 1, pos.line, false)[1] or ""
    for s, e in line:gmatch "()#%x%x%x%x%x%x()" do
      if pos.column >= s and pos.column < e then
        return require("minty.huefy").open()
      end
    end

    require("menu").open("default", { mouse = true })
  end)
end

return M
