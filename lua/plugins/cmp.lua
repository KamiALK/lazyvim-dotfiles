-- ~/.config/nvim/lua/plugins/cmp.lua
return {
  -- nvim-cmp principal
  {
    "hrsh7th/nvim-cmp",
    enabled = true,
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "kristijanhusak/vim-dadbod-completion",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      -- Obtener los íconos originales
      local kinds = vim.deepcopy(require("lazyvim.config").icons.kinds)

      -- Sobrescribir algunos íconos
      kinds.Function = "ƒ" -- ícono personalizado para funciones
      kinds.Variable = "𝓍" -- ícono personalizado para variables
      kinds.Class = "🏷️" -- ícono personalizado para clases
      local cmp = require("cmp")

      cmp.setup({
        ----    vamos a importar los emogis de lazy
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end, -- No usamos snippets
        },

        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { "i", "s" }),
        }),

        sources = cmp.config.sources({
          {
            name = "nvim_lsp",
            entry_filter = function(entry, ctx)
              local clients = vim.lsp.get_active_clients({ bufnr = ctx.bufnr })
              return #clients > 0
            end,
          },
          { name = "nvim_lsp" },
          { name = "vim-dadbod-completion" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),

        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },

        formatting = {
          format = function(entry, vim_item)
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              buffer = "[Buffer]",
              path = "[Path]",
              ["vim-dadbod-completion"] = "[DB]",
              luasnip = "[Snippet]",
            })[entry.source.name]

            -- Aquí usamos los íconos originales_
            -- kamiloaqui
            local kinds = require("lazyvim.config").icons.kinds
            if kinds[vim_item.kind] then
              vim_item.kind = kinds[vim_item.kind] .. " " .. vim_item.kind
            end

            return vim_item
          end,
        },
      })

      -- SQL files
      cmp.setup.filetype({ "sql", "mysql", "plsql" }, {
        sources = cmp.config.sources({
          { name = "vim-dadbod-completion" },
          { name = "buffer" },
        }),
      })

      -- Command line
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
      })

      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = "buffer" } },
      })
    end,
  },

  -- Desactivar blink.cmp por separado
  {
    "saghen/blink.cmp",
    enabled = false,
  },
}
