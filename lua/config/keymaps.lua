local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- mi creados por mi
keymap.set("n", "<C-z>", "u", { noremap = true, silent = true })
keymap.set("i", "ii", "<esc>")
keymap.set("t", "ii", [[<C-\><C-n>]])
keymap.set("v", "ii", "<Esc>", { noremap = true, silent = true })
keymap.set("x", "ii", "<Esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap(
  "i", -- modo insert
  "<A-,>", -- Alt + a
  "<Esc>A", -- lo que quieres que haga
  { noremap = true, silent = true }
)

keymap.set("n", "<CR>", function()
  vim.cmd("startinsert") -- Cambia a modo terminal insert
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "n", true)
end, { noremap = true, silent = true })
--split window

-- keymap.set("n", "tr", ":split<return>term vertical resize -10<cr>")
keymap.set("n", "ty", ":split term://zsh | resize 10<CR>")
keymap.set("n", "tr", ":vsplit term://zsh <CR>", opts)
-- crear un tab
keymap.set("n", "te", ":tabedit<return>", opts)

keymap.set("n", "th", ":q<CR>", { noremap = true, silent = true })

-- keymap.set("n", "zs", ":split<return> | resize 10<CR>", opts)
keymap.set("n", "zs", ":split | resize 10<CR>", opts)

keymap.set("n", "zv", ":vsplit<return>", opts)

-- Resize window using <ctrl> arrow keys
keymap.set("n", "<A-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
keymap.set("n", "<A-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
keymap.set("n", "<A-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
keymap.set("n", "<A-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- primero seleccionar con el modo visual y luego indentar
keymap.set("v", ">", ">gv", { desc = "after tab in re-select the same" })
keymap.set("v", "<", "<gv", { desc = "after tab out re-select the same" })
keymap.set("n", "n", "nzzzv", { desc = "Goes to the next result on the seach and put the cursor in the middle" })
keymap.set("n", "N", "Nzzzv", { desc = "Goes to the prev result on the seach and put the cursor in the middle" })

-- pegar al portapapeles
keymap.set({ "n", "v" }, "<leader>y", [["+y]])

--mover las lineas arriba o abajo
keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })
keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move Up" })

-- correr archivos python
vim.api.nvim_set_keymap(
  "n",
  "<A-x>",
  ":RunPythonFile<CR>",
  { noremap = true, silent = true, desc = "Run .py file via terminal" }
)
-- detener archivos python
vim.api.nvim_set_keymap(
  "n",
  "<A-p>",
  ":StopPythonPrueba<CR>",
  { noremap = true, silent = true, desc = "Run .py file via terminal" }
)
vim.api.nvim_set_keymap(
  "n",
  "<A-u>",
  ":JavaCompileAndRunJavaFile<CR>",
  { noremap = true, silent = true, desc = "Run .java file via terminal" }
)

vim.api.nvim_set_keymap(
  "n",
  "<A-m>",
  ":MavenRun<CR>",
  { noremap = true, silent = true, desc = "Run Maven build and execute JAR" }
)
-- crear paquetes y clases automaticamente

vim.api.nvim_set_keymap(
  "n",
  "<leader>ni",
  ":set modifiable | lua require('jdtls').code_action()<CR>",
  { noremap = true, silent = true }
)

vim.fn.setreg("t", ":Typescript\n\22Hii")
-- Navegación entre ventanas con Alt + hjkl en modo normal
vim.keymap.set("n", "<A-a>", "<C-w>h", { desc = "Go to left window" })
vim.keymap.set("n", "<A-s>", "<C-w>j", { desc = "Go to lower window" })
vim.keymap.set("n", "<A-w>", "<C-w>k", { desc = "Go to upper window" })
vim.keymap.set("n", "<A-d>", "<C-w>l", { desc = "Go to right window" })

-- Navegación entre ventanas con Alt + hjkl en modo insert
vim.keymap.set("i", "<A-a>", "<C-\\><C-N><C-w>h", { desc = "Go to left window" })
vim.keymap.set("i", "<A-s>", "<C-\\><C-N><C-w>j", { desc = "Go to lower window" })
vim.keymap.set("i", "<A-w>", "<C-\\><C-N><C-w>k", { desc = "Go to upper window" })
vim.keymap.set("i", "<A-d>", "<C-\\><C-N><C-w>l", { desc = "Go to right window" })

-- Navegación entre ventanas con Alt + hjkl en modo terminal
vim.keymap.set("t", "<A-a>", "<C-\\><C-N><C-w>h", { desc = "Go to left window" })
vim.keymap.set("t", "<A-s>", "<C-\\><C-N><C-w>j", { desc = "Go to lower window" })
vim.keymap.set("t", "<A-w>", "<C-\\><C-N><C-w>k", { desc = "Go to upper window" })
vim.keymap.set("t", "<A-d>", "<C-\\><C-N><C-w>l", { desc = "Go to right window" })

-- Normal mode
keymap.set("n", "<leader>aa", ":CopilotChatToggle<CR>", { noremap = true, silent = true })

-- Insert mode → salir a Normal y ejecutar
keymap.set("i", "<leader>aa", "<Esc>:CopilotChatToggle<CR>", { noremap = true, silent = true })

-- Terminal mode → salir a Normal y ejecutar
keymap.set("t", "<leader>aa", "<C-\\><C-n>:CopilotChatToggle<CR>", { noremap = true, silent = true })
