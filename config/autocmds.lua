-- vim.api.nvim_create_autocmd("VimEnter", {
--   callback = function()
--     vim.cmd.colorscheme("solarized-osaka")
--   end,
-- })

vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"sql",
		"mysql",
		"plsql",
		"lua",
		"python",
		"javascript",
		"typescript",
		"bash",
		"sh",
	},
	callback = function()
		local commentstrings = {
			sql = "-- %s",
			mysql = "-- %s",
			plsql = "-- %s",
			lua = "-- %s",
			python = "# %s",
			javascript = "// %s",
			typescript = "// %s",
			bash = "# %s",
			sh = "# %s",
		}

		local ft = vim.bo.filetype
		if commentstrings[ft] then
			vim.bo.commentstring = commentstrings[ft]
		end
	end,
})

-- Autocommand: cuando abras un .html, quita biome si está enganchado
vim.api.nvim_create_autocmd("FileType", {
	pattern = "html",
	callback = function()
		-- revisa todos los clientes conectados al buffer actual
		for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
			if client.name == "biome" then
				vim.lsp.buf_detach_client(0, client.id)
				vim.notify("Biome desactivado en HTML", vim.log.levels.INFO)
			end
		end
	end,
})
