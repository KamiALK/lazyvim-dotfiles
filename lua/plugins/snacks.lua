-- ~/.config/nvim/lua/plugins/snacks_disable.lua
return {
  {
    "folke/snacks.nvim",
    opts = {
      explorer = { enabled = false }, -- desactiva Snacks Explorer
    },
    keys = { -- desactiva atajos que abrían Snacks Explorer
      { "<leader>fe", false },
      { "<leader>fE", false },
      { "<leader>e", false },
    },
  },
}
