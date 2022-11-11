local lspconfig = require 'lspconfig'

local opts = {noremap = true, silent = true}
local map = vim.api.nvim_set_keymap


map("n", "<A-2>", "<cmd>FloatermToggle<cr>", {noremap=false})
map("n", "<C-p>", "<cmd>read !xsel --clipboard --output<cr>", opts)
map("n", "<C-y>", "<cmd>w !xsel -ib<cr>", opts)
map("n", "<A-1>", "<cmd>NvimTreeToggle<cr>", opts)
map('n', '<C-b>', [[<cmd>lua require('telescope.builtin').buffers()<cr>]], opts)
map('n', '<C-f>', [[<cmd>lua require('telescope.builtin').find_files()<cr>]],
    opts)
map('n', '<C-s>', [[<cmd>lua require('telescope.builtin').live_grep()<cr>]],
    opts)
map('n', '<C-e>', [[<cmd>lua require('telescope.builtin').diagnostics()<cr>]],
    opts)

map('n', '<C-h>', [[<cmd>HopChar1<cr>]], opts)

map('n', [[<C-/>]], [[<cmd>CommentToggle<cr>]], opts)
map('v', [[<C-/>]], [[:CommentToggle<cr>]], opts)

local rt = require('rust-tools')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local on_attach = function(client, bufnr)

    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end
    -- enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- mappings.

    -- see `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>',
                   opts)
    buf_set_keymap('n', '<space>d',
                   '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    buf_set_keymap('n', '<space>r', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    buf_set_keymap('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<cr>',
                   opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<cr>',
                   opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.set_loclist()<cr>',
                   opts)
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.format()<cr>", opts)
    -- get signatures (and _only_ signatures) when in argument lists.
    -- P

    -- vim.keymap.set("n", "<space>a", require('rust-tools').runnables.runnables(),
    --                {buffer = bufnr})
    buf_set_keymap("n", "<space>a",
                   "<cmd>lua  require('rust-tools').runnables.runnables()<cr>",
                   opts)
    require"lsp_signature".on_attach({
        doc_lines = 0,
        handler_opts = {border = "none"}
    })
end

rt.setup({
    server = {
        on_attach = on_attach,
        flags = {debounce_text_changes = 150},
        settings = {
            ["rust-analyzer"] = {
                cargo = {allfeatures = true},
                completion = {postfix = {enable = false}}
            }
        },
        capabilities = capabilities
    }
})
local cmp = require 'cmp'

cmp.setup({
    snippet = {expand = function(args) vim.fn["vsnip#anonymous"](args.body) end},
    mapping = {
        -- tab immediately completes. c-n/c-p to select.
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<tab>'] = cmp.mapping.confirm({select = true})
    },
    sources = cmp.config.sources({{name = 'nvim_lsp'}}, {{name = 'path'}}),
    experimental = {ghost_text = true}
})
