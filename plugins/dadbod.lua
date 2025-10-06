-- ~/.config/nvim/lua/plugins/dadbod.lua
return {
	{
		"tpope/vim-dadbod",
		cmd = { "DB", "DBUI" },
	},
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod", lazy = true },
			{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
		},
		init = function()
			-- Configuración de variables globales
			vim.g.db_ui_use_nerd_fonts = 1
			vim.g.db_ui_winwidth = 30
			vim.g.db_ui_notification_width = 50

			-- Configuración del autocompletado
			vim.g.db_ui_auto_execute_table_helpers = 1
			vim.g.db_ui_save_location = vim.fn.stdpath("config") .. require("plenary.path").path.sep .. "db_ui"

			-- Habilitar autocompletado por defecto para archivos SQL
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "sql", "mysql", "plsql" },
				callback = function()
					local cmp = require("cmp")
					cmp.setup.buffer({
						sources = {
							{ name = "vim-dadbod-completion" },
							{ name = "buffer" },
						},
					})
				end,
			})
		end,
		config = function()
			-- Keymaps
			vim.keymap.set("n", "<F12>", "<cmd>DBUIToggle<cr>", { desc = "Toggle DBUI" })
			vim.keymap.set("n", "<F11>", "<cmd>DBUIFindBuffer<cr>", { desc = "Find DB Buffer" })

			-- Keymap para ejecutar consulta
			vim.keymap.set("v", "<leader>db", "<cmd>'<,'>DB<cr>", { desc = "Execute SQL selection" })
			vim.keymap.set("n", "<leader>db", "<cmd>%DB<cr>", { desc = "Execute SQL file" })
		end,
	},
}
