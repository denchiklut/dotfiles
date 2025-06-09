local builtin = require "statuscol.builtin"

require("statuscol").setup {
  ft_ignore = { "NvimTree", "codecompanion", "oil" },
  segments = {
    {
      text = { builtin.foldfunc, " " },
      condition = { true, builtin.not_empty },
      click = "v:lua.ScFa",
    },
    {
      text = { builtin.lnumfunc, " " },
      condition = { true, builtin.not_empty },
      click = "v:lua.ScLa",
    },
    {
      text = { "%s" },
      condition = { true, builtin.not_empty },
      click = "v:lua.ScSa",
    },
  },
}
