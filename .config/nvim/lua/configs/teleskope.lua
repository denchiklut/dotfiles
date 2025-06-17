local map = vim.keymap.set

local builtin = require "telescope.builtin"
local sorter = require "telescope.sorters"
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local actions = require "telescope.actions"
local make_entry = require "telescope.make_entry"
local action_state = require "telescope.actions.state"
local live_grep = require("telescope.builtin").live_grep
local conf = require("telescope.config").values

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
      "-g",
      "!**/{.git,.vercel,.next,dist,node_modules}/**",
    },
  }
end, { desc = "Find files (including hidden)" })

map("n", "<leader>fW", function()
  pickers
    .new({}, {
      debounce = 100,
      prompt_title = "live grep (including hidden)",
      finder = finders.new_async_job {
        command_generator = function(prompt)
          if not prompt or prompt == "" then
            return nil
          end

          local pieces = vim.split(prompt, "  ")
          local cmd = { "rg" }

          if pieces[1] then
            table.insert(cmd, "-e")
            table.insert(cmd, pieces[1])
          end

          if pieces[2] then
            table.insert(cmd, "-g")
            table.insert(cmd, pieces[2])
          end

          return vim.tbl_flatten {
            cmd,
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
            "--no-ignore",
            "-g",
            "!**/{.git,.vercel,.next,dist,node_modules}/**",
          }
        end,
        entry_maker = make_entry.gen_from_vimgrep {},
        cwd = vim.uv.cwd(),
      },
      previewer = conf.grep_previewer {},
      sorter = sorter.empty(),
    })
    :find()
end, { desc = "telescope live grep (including hidden)" })

map("n", "<leader>fd", function()
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
              "-g",
              "!**/{.git,.vercel,.next,dist,node_modules}/**",
            },
          }
        end)
        return true
      end,
    })
    :find()
end, { desc = "Find files (in the directory)" })

map("n", "<leader>fg", function()
  pickers
    .new({}, {
      prompt_title = "Select a directory for live grep",
      finder = finders.new_oneshot_job { "fd", "--type", "d", "--hidden", "--exclude", ".git" },
      sorter = conf.generic_sorter {},
      attach_mappings = function(_, m)
        m({ "i", "n" }, "<CR>", function(bufnr)
          local entry = action_state.get_selected_entry()
          actions.close(bufnr)

          live_grep {
            cwd = entry[1],
            prompt_title = "Live Grep in " .. entry[1],
            additional_args = function()
              return {
                "--hidden",
                "--no-ignore",
                "-g",
                "!**/{.git,.vercel,.next,dist,node_modules}/**",
              }
            end,
          }
        end)
        return true
      end,
    })
    :find()
end, { desc = "telescope live grep (in the directory)" })
