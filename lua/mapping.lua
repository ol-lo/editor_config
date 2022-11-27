local silent = {noremap = true, silent = true}
local map = vim.api.nvim_set_keymap

-- map("n", "<C-p>", "<cmd>read !xsel --clipboard --output<cr>", silent)
-- map("n", "<C-y>", "<cmd>w !xsel -ib<cr>", silent)
map("n", "<C-p>", "\"+p", silent)
map("n", "<C-y>", "<cmd>w !xsel -ib<cr>", silent)
map("v", "<C-y>", "\"+y", silent)

-- map("v", "<A-w>", "<C-\\><C-n><C-w>w", silent) does not work
map("v", "<Esc>", "<C-\\><C-n>", silent)
map("t", "<Esc>", "<C-\\><C-n>", silent)

map("n", "gd", "gdzz", silent)
map("n", "go", "gozz", silent)

map("n", "<A-1>", "<cmd>NvimTreeToggle<cr>", silent)
map("n", "<A-2>", "<cmd>FloatermToggle<cr>", {noremap = false})
map("t", "<A-2>", "<cmd>FloatermToggle<cr>", {noremap = false})
map("t", "<A-n>", "<cmd>FloatermNext<cr>", {noremap = false})
map("t", "<A-N>", "<cmd>FloatermNew<cr>", {noremap = false})
map("t", "<A-p>", "<cmd>FloatermPrev<cr>", {noremap = false})
map("t", "<A-x>", "<cmd>FloatermKill<cr>", {noremap = false})

map('n', '<C-b>', [[<cmd>lua require('telescope.builtin').buffers()<cr>]],
    silent)
map('n', '<C-f>', [[<cmd>lua require('telescope.builtin').find_files()<cr>]],
    silent)
map('n', '<C-s>', [[<cmd>lua require('telescope.builtin').live_grep()<cr>]],
    silent)
map('n', '<C-e>', [[<cmd>lua require('telescope.builtin').diagnostics()<cr>]],
    silent)

map('n', '<C-h>', [[<cmd>HopChar1<cr>]], silent)

-- map('n', [[<C-\>]], [[<cmd>CommentToggle<cr>]], silent)
-- map('v', [[<C-\>]], [[:CommentToggle<cr>]], silent)

-- LSP
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", silent)
map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", silent)
map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', silent)
map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', silent)
map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', silent)
map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', silent)
map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', silent)
map('n', '<space>d', '<cmd>lua vim.lsp.buf.type_definition()<cr>', silent)
map('n', '<space>r', '<cmd>lua vim.lsp.buf.rename()<cr>', silent)
map('n', '<space>a', '<cmd>lua vimlsp.buf.code_action()<cr>', silent)
map('n', 'gr',
    '<cmd>lua vim.lsp.buf.references({ includeDeclaration = false })<cr>',
    silent)
map('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<cr>', silent)
map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', silent)
map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', silent)
map('n', '<space>q', '<cmd>lua vim.diagnostic.set_loclist()<cr>', silent)
map("n", "<space>f", "<cmd>lua vim.lsp.buf.format()<cr>", silent)
-- get signatures (and _only_ signatures) when in argument lists.
-- P
-- map("n", "<C-Space>", "<cmd>lua vim.lsp.buf.code_action()<CR>", silent)
-- vim.keymap.set("n", "<space>a", require('rust-tools').runnables.runnables(),
--                {buffer = bufnr})
map("n", "<space>a",
    "<cmd>lua  require('rust-tools').runnables.runnables()<cr>", silent)

map("n", "<C-t>t", "<cmd>FloatermToggle<cr>", silent)
map("n", "<C-t>t", "<cmd>FloatermToggle<cr>", silent)
map("t", "<C-t>h", "<cmd>FloatermHide<cr>", silent)
map("t", "<C-t>h", "<cmd>FloatermHide<cr>", silent)
-- map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", silent)
-- map("v", "<leader>ca", "<cmd>'<,'>lua vim.lsp.buf.range_code_action()<CR>", silent)
-- map("n", "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<CR>", silent)
-- map("n", "<leader>cf", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", silent)
-- map("v", "<leader>cf", "<cmd>'<.'>lua vim.lsp.buf.range_formatting()<CR>", silent)
-- map("n", "<leader>cl", "<cmd>lua vim.diagnostic.open_float({ border = 'rounded', max_width = 100 })<CR>", silent)
-- map("n", "gl", "<cmd>lua vim.diagnostic.open_float({ border = 'rounded', max_width = 100 })<CR>", silent)
-- map("n", "L", "<cmd>lua vim.lsp.buf.signature_help()<CR>", silent)
-- map("n", "]g", "<cmd>lua vim.diagnostic.goto_next({ float = { border = 'rounded', max_width = 100 }})<CR>", silent)
-- map("n", "[g", "<cmd>lua vim.diagnostic.goto_prev({ float = { border = 'rounded', max_width = 100 }})<CR>", silent)
