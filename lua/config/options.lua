-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- LSP Server para Python (pyright por defecto, o basedpyright)
vim.g.lazyvim_python_lsp = false -- o "basedpyright"

-- Configuración de Ruff (formateador y linter)
vim.g.lazyvim_python_ruff = false -- o "ruff_lsp"

vim.opt.wrap = true
