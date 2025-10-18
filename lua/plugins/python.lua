-- lua/plugins/python.lua
return {
  -- Treesitter para Python
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "python" })
      end
    end,
  },

  -- LSP para Python
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        bashls = {},
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "basic",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                autoImportCompletions = true,
              },
            },
          },
        },
        ruff_lsp = {
          init_options = {
            settings = {
              args = {},
            },
          },
        },
      },
    },
  },

  -- Mason para instalar automáticamente herramientas de Python
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "pyright", -- LSP server
        "ruff-lsp", -- Linter/formatter
        "black", -- Formatter
        "isort", -- Import sorter
        "debugpy", -- Debugger
      })
    end,
  },

  -- Formateo con conform
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "black", "isort" },
      },
      formatters = {
        black = {
          prepend_args = { "--line-length", "88" },
        },
      },
    },
  },

  -- Debug con DAP
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      {
        "mfussenegger/nvim-dap-python",
        keys = {
          {
            "<leader>dPt",
            function()
              require("dap-python").test_method()
            end,
            desc = "Debug Test Method",
            ft = "python",
          },
          {
            "<leader>dPc",
            function()
              require("dap-python").test_class()
            end,
            desc = "Debug Test Class",
            ft = "python",
          },
        },
        config = function()
          local path = require("mason-registry").get_package("debugpy"):get_install_path()
          require("dap-python").setup(path .. "/venv/bin/python")
        end,
      },
    },
  },

  -- Mejorar experiencia con Python
  {
    "linux-cultist/venv-selector.nvim",
    cmd = "VenvSelect",
    opts = {
      name = {
        "venv",
        ".venv",
        "env",
        ".env",
      },
    },
    keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv" } },
  },

  -- Neotest para testing
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-python",
    },
    keys = {
      {
        "<leader>tt",
        function()
          require("neotest").run.run(vim.fn.expand("%"))
        end,
        desc = "Run File Tests",
      },
      {
        "<leader>tT",
        function()
          require("neotest").run.run(vim.loop.cwd())
        end,
        desc = "Run All Test Files",
      },
      {
        "<leader>tr",
        function()
          require("neotest").run.run()
        end,
        desc = "Run Nearest Test",
      },
      {
        "<leader>ts",
        function()
          require("neotest").summary.toggle()
        end,
        desc = "Toggle Summary",
      },
      {
        "<leader>to",
        function()
          require("neotest").output.open({ enter = true, auto_close = true })
        end,
        desc = "Show Output",
      },
      {
        "<leader>tO",
        function()
          require("neotest").output_panel.toggle()
        end,
        desc = "Toggle Output Panel",
      },
      {
        "<leader>tS",
        function()
          require("neotest").run.stop()
        end,
        desc = "Stop Tests",
      },
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-python")({
            runner = "pytest",
            python = function()
              -- Buscar Python en venv primero, luego usar el del sistema
              local venv_path = os.getenv("VIRTUAL_ENV")
              if venv_path then
                return venv_path .. "/bin/python"
              end

              -- Buscar .venv local
              local cwd = vim.fn.getcwd()
              local venv_python = cwd .. "/.venv/bin/python"
              if vim.fn.executable(venv_python) == 1 then
                return venv_python
              end

              -- Fallback a python del sistema
              return vim.fn.exepath("python3") or vim.fn.exepath("python")
            end,
            pytest_discover_instances = true,
          }),
        },
        discovery = {
          concurrent = 1,
          enabled = true,
        },
        running = {
          concurrent = true,
        },
        summary = {
          animated = true,
          enabled = true,
        },
      })
    end,
  },

  -- Jupyter notebooks support (opcional)
  {
    "benlubas/molten-nvim",
    version = "^1.0.0",
    build = ":UpdateRemotePlugins",
    init = function()
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 20
      vim.g.molten_wrap_output = true
      vim.g.molten_virt_text_output = true
      vim.g.molten_virt_lines_off_by_1 = true
    end,
    keys = {
      { "<leader>mi", ":MoltenInit<CR>", desc = "Initialize Molten" },
      { "<leader>me", ":MoltenEvaluateOperator<CR>", desc = "Evaluate Operator", mode = "n" },
      { "<leader>ml", ":MoltenEvaluateLine<CR>", desc = "Evaluate Line" },
      { "<leader>mr", ":MoltenReevaluateCell<CR>", desc = "Re-evaluate Cell" },
      { "<leader>mv", ":<C-u>MoltenEvaluateVisual<CR>", desc = "Evaluate Visual", mode = "v" },
      { "<leader>md", ":MoltenDelete<CR>", desc = "Delete Cell" },
      { "<leader>mh", ":MoltenHideOutput<CR>", desc = "Hide Output" },
      { "<leader>ms", ":MoltenShowOutput<CR>", desc = "Show Output" },
    },
  },
}
