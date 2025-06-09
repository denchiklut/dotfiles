local M = {}

M.closeOther = function()
  local current = vim.api.nvim_get_current_buf()
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if bufnr ~= current and vim.bo[bufnr].buflisted then
      local bufname = vim.api.nvim_buf_get_name(bufnr)

      if bufname ~= "" then
        bufname = vim.fn.fnamemodify(bufname, ":t")
      else
        bufname = "[No Name] (" .. bufnr .. ")"
      end

      if vim.bo[bufnr].modified then
        local choice = vim.fn.confirm("Save changes to buffer: " .. bufname .. "?", "&Yes\n&No\n&Cancel")

        if choice == 1 then
          vim.api.nvim_buf_call(bufnr, function()
            vim.cmd "w"
          end)
        elseif choice == 2 then
          vim.api.nvim_buf_delete(bufnr, { force = true })
        elseif choice == 3 then
          return
        end
      else
        vim.api.nvim_buf_delete(bufnr, { force = true })
      end
    end
  end
end

return M
