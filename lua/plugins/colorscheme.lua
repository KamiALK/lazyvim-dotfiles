-- ~/.config/nvim/lua/plugins/solarized-osaka.lua
return {
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = false, -- siempre cargado
    priority = 1000, -- más alto que otros temas
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
        comments = { italic = true },
        keywords = { italic = true },
      },
    },
    config = function(_, opts)
      -- setup del tema
      require("solarized-osaka").setup(opts)
      -- aplicar colorscheme
      vim.cmd.colorscheme("solarized-osaka")

      -- 🔒 forzar que nunca cambie
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
          if vim.g.colors_name ~= "solarized-osaka" then
            vim.schedule(function()
              vim.cmd.colorscheme("solarized-osaka")
            end)
          end
        end,
      })
    end,
  },
}
