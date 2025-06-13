local map = vim.keymap.set
local builtin = require "telescope.builtin"

map("n", "<leader>fc", builtin.commands, { desc = "Commands" })
map("n", "<leader>fr", builtin.registers, { desc = "Registers" })
map("n", "<leader>fk", builtin.keymaps, { desc = "Keymaps" })
map("n", "<leader>gr", builtin.lsp_references, { desc = "LSP: References" })
map("n", "<leader>gb", builtin.git_branches, { desc = "Git: Branches" })
map("n", "<leader>gh", builtin.git_bcommits, { desc = "Git: History" })
map("n", "<leader>gs", builtin.git_stash, { desc = "Git: Stashes" })

map("n", "<leader>fF", function()
  builtin.find_files {
    hidden = true,
    find_command = {
      "rg",
      "--files",
      "--hidden",
      "--no-ignore",
      "--glob",
      "!**/.git/**",
      "--glob",
      "!**/.vercel/**",
      "--glob",
      "!**/.next/**",
      "--glob",
      "!**/dist/**",
      "--glob",
      "!**/node_modules/**",
    },
  }
end, { desc = "Find files (including hidden)" })

map("n", "<leader>fW", function()
  builtin.live_grep {
    additional_args = function()
      return {
        "--hidden",
        "--no-ignore",
        "--glob",
        "!**/.git/**",
        "--glob",
        "!**/.vercel/**",
        "--glob",
        "!**/.next/**",
        "--glob",
        "!**/dist/**",
        "--glob",
        "!**/node_modules/**",
      }
    end,
  }
end, { desc = "telescope live grep (including hidden)" })

map("n", "<leader>fd", function()
  local pickers = require "telescope.pickers"
  local finders = require "telescope.finders"
  local conf = require("telescope.config").values
  local actions = require "telescope.actions"
  local action_state = require "telescope.actions.state"

  pickers
    .new({}, {
      prompt_title = "Select a directory",
      finder = finders.new_oneshot_job { "fd", "--type", "d", "--hidden", "--exclude", ".git" },
      sorter = conf.generic_sorter {},
      attach_mappings = function(_, m)
        m({ "i", "n" }, "<CR>", function(bufnr)
          local entry = action_state.get_selected_entry()
          actions.close(bufnr)

          require("telescope.builtin").find_files {
            cwd = entry[1],
            hidden = true,
            prompt_title = "Find Files in " .. entry[1],
            find_command = {
              "rg",
              "--files",
              "--hidden",
              "--no-ignore",
              "--glob",
              "!**/.git/**",
              "--glob",
              "!**/.vercel/**",
              "--glob",
              "!**/.next/**",
              "--glob",
              "!**/dist/**",
              "--glob",
              "!**/node_modules/**",
            },
          }
        end)
        return true
      end,
    })
    :find()
end, { desc = "Find files (in the directory)" })

map("n", "<leader>fg", function()
  local pickers = require "telescope.pickers"
  local finders = require "telescope.finders"
  local conf = require("telescope.config").values
  local actions = require "telescope.actions"
  local action_state = require "telescope.actions.state"

  pickers
    .new({}, {
      prompt_title = "Select a directory for live grep",
      finder = finders.new_oneshot_job { "fd", "--type", "d", "--hidden", "--exclude", ".git" },
      sorter = conf.generic_sorter {},
      attach_mappings = function(_, m)
        m({ "i", "n" }, "<CR>", function(bufnr)
          local entry = action_state.get_selected_entry()
          actions.close(bufnr)

          require("telescope.builtin").live_grep {
            cwd = entry[1],
            prompt_title = "Live Grep in " .. entry[1],
            additional_args = function()
              return {
                "--hidden",
                "--no-ignore",
                "--glob",
                "!**/.git/**",
                "--glob",
                "!**/.vercel/**",
                "--glob",
                "!**/.next/**",
                "--glob",
                "!**/dist/**",
                "--glob",
                "!**/node_modules/**",
              }
            end,
          }
        end)
        return true
      end,
    })
    :find()
end, { desc = "telescope live grep (in the directory)" })
