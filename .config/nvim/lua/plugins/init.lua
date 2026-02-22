return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    ft = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
    },
    opts = {
      filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
      settings = {
        tsserver_file_preferences = {
          includeInlayParameterNameHints = "literals",
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeCompletionsForModuleExports = true,
        },
      },
    },
  },
  { import = "nvchad.blink.lazyspec" },
  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    opts = {
      signs = false,
      keywords = {
        TODO = { icon = " ", color = "warning", alt = { "todo" } },
      },
    },
  },
  {
    "Saghen/blink.cmp",
    opts = {
      completion = {
        ghost_text = {
          enabled = false,
        },
        menu = {
          draw = {
            align_to = "kind_icon",
          },
        },
      },
      keymap = {
        ["<C-n>"] = { "show", "select_next" },
      },
      cmdline = {
        keymap = {
          ["<Tab>"] = { "show", "accept" },
        },
        completion = { menu = { auto_show = true } },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "typescript",
        "javascript",
        "tsx",
        "html",
        "css",
        "json",
        "jsonc",
        "yaml",
        "toml",
        "markdown",
        "markdown_inline",
        "bash",
        "regex",
        "dockerfile",
        "gitignore",
        "python",
      },
    },
  },
  { "nvzone/volt", lazy = true },
  { "nvzone/menu", lazy = true },
  {
    "nvzone/minty",
    cmd = { "Shades", "Huefy" },
  },
  {
    "nvzone/typr",
    dependencies = "nvzone/volt",
    opts = {},
    cmd = { "Typr", "TyprStats" },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = require "configs.gitsigns",
  },
  {
    "rmagatti/auto-session",
    lazy = false,
    opts = {
      suppressed_dirs = { "~/" },
    },
  },
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
      "TmuxNavigatorProcessList",
    },
    init = function()
      vim.g.tmux_navigator_no_mappings = 1
    end,
  },
  {
    "stevearc/oil.nvim",
    lazy = false,
    opts = {
      default_file_explorer = true,
      delete_to_trash = true,
    },
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {},
    dependencies = { "MunifTanjim/nui.nvim", "folke/which-key.nvim" },
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, conf)
      conf.defaults.mappings.i = {
        ["<C-t>"] = require("trouble.sources.telescope").open,
        ["<Esc>"] = require("telescope.actions").close,
      }
      conf.defaults.mappings.n = {
        ["<C-t>"] = require("trouble.sources.telescope").open,
        ["q"] = require("telescope.actions").close,
      }

      return conf
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    event = "VeryLazy",
    config = function()
      require("telescope").load_extension "ui-select"
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {},
    keys = require("configs.trouble").keys,
  },
  {
    "kevinhwang91/nvim-ufo",
    event = "VeryLazy",
    dependencies = {
      "kevinhwang91/promise-async",
      {
        "luukvbaal/statuscol.nvim",
        config = function()
          require "configs.statuscol"
        end,
      },
    },
    config = function()
      require "configs.ufo"
    end,
  },
  {
    "vim-test/vim-test",
    cmd = {
      "TestNearest",
      "TestFile",
      "TestSuite",
      "TestLast",
      "TestVisit",
    },
    dependencies = { "preservim/vimux" },
    config = function()
      vim.cmd [[let test#strategy = 'vimux']]
    end,
  },
  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = require("configs.flash").keys,
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      styles = {
        above_cursor = {
          backdrop = false,
          position = "float",
          title_pos = "left",
          noautocmd = true,
          relative = "cursor",
          row = -3,
          col = 0,
        },
      },
      picker = {
        actions = {
          opencode_send = function(...)
            return require("opencode").snacks_picker_send(...)
          end,
        },
      },
      terminal = {},
      input = {
        win = {
          style = "above_cursor",
        },
      },
      bigfile = { enabled = true },
    },
  },
  {
    "windwp/nvim-ts-autotag",
    event = "VeryLazy",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "NeogitOrg/neogit",
    event = "VeryLazy",
    dependencies = { "sindrets/diffview.nvim" },
  },
  {
    "mg979/vim-visual-multi",
    event = "VeryLazy",
    init = function()
      vim.g.VM_maps = {
        ["Find Under"] = "<M-m>",
        ["Find Subword Under"] = "<M-m>",
        ["Add Cursor Down"] = "<S-M-j>",
        ["Add Cursor Up"] = "<S-M-k>",
      }
    end,
  },
  {
    "lucidph3nx/nvim-sops",
    keys = {
      { "<leader>ef", vim.cmd.SopsEncrypt, desc = "Encrypt File" },
      { "<leader>df", vim.cmd.SopsDecrypt, desc = "Decrypt File" },
    },
  },
  {
    "tpope/vim-surround",
    event = "VeryLazy",
  },
  {
    "nickjvandyke/opencode.nvim",
    event = "VeryLazy",
    version = "*",
    init = function()
      vim.g.opencode_opts = {
        provider = {
          snacks = {
            win = {
              enter = true,
            },
          },
        },
      }
    end,
  },
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    version = "*",
    opts = {},
  },
  {
    "echasnovski/mini.move",
    version = "*",
    event = "VeryLazy",
    opts = {
      mappings = {
        left = "<M-h>",
        right = "<M-l>",
        down = "<M-j>",
        up = "<M-k>",
        line_left = "<M-h>",
        line_right = "<M-l>",
        line_down = "<M-j>",
        line_up = "<M-k>",
      },
      options = {
        reindent_linewise = true,
      },
    },
  },

  {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    opts = {
      default = {
        dir_path = os.getenv "HOME" .. "/Desktop",
        prompt_for_file_name = false,
        use_absolute_path = true,
      },
    },
    keys = {
      { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    event = "VeryLazy",
    opts = {
      heading = { position = "inline" },
      sign = { enabled = false },
      file_types = { "markdown" },
    },
    ft = { "markdown" },
    config = function(_, opts)
      require("render-markdown").setup(opts)
      require("configs.highlight").setup()
    end,
  },
}
