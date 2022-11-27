local typescript_ok, typescript = pcall(require, 'typescript')
local mason_ok, mason = pcall(require, 'mason')
local mason_lsp_ok, mason_lsp = pcall(require, 'mason-lspconfig')

require("mason").setup()

mason_lsp.setup {
    -- A list of servers to automatically install if they're not already installed
    ensure_installed = {
        "cssls", "eslint", "html", "jsonls", "sumneko_lua", "tailwindcss",
        "tsserver", "volar", "pyright"
    },

    -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
    -- This setting has no relation with the `ensure_installed` setting.
    -- Can either be:
    --   - false: Servers are not automatically installed.
    --   - true: All servers set up via lspconfig are automatically installed.
    --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
    --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
    automatic_installation = true
}

local rt = require('rust-tools')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
require"lsp_signature".on_attach({
    doc_lines = 0,
    handler_opts = {border = "none"}
})
local on_attach = function(client, bufnr)

    if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_create_augroup("lsp_document_highlight", {clear = true})
        vim.api.nvim_clear_autocmds {
            buffer = bufnr,
            group = "lsp_document_highlight"
        }
        vim.api.nvim_create_autocmd("CursorHold", {
            callback = vim.lsp.buf.document_highlight,
            buffer = bufnr,
            group = "lsp_document_highlight",
            desc = "Document Highlight"
        })
        vim.api.nvim_create_autocmd("CursorMoved", {
            callback = vim.lsp.buf.clear_references,
            buffer = bufnr,
            group = "lsp_document_highlight",
            desc = "Clear All the References"
        })
    end

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
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({select = true}), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.'<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<tab>'] = cmp.mapping.confirm({select = true})
    },
    sources = cmp.config.sources({{name = 'nvim_lsp'}}, {{name = 'path'}}),
    experimental = {ghost_text = true}
})
local lspconfig = require 'lspconfig'
-- if typescript_ok then
--     typescript.setup({
--
--         on_attach = function(client, bufnr)
--             -- Modifying a server's capabilities is not recommended and is no longer
--             -- necessary thanks to the `vim.lsp.buf.format` API introduced in Neovim
--             -- 0.8. Users with Neovim 0.7 needs to uncomment below lines to make tsserver formatting work (or keep using eslint).
--
--             client.server_capabilities.documentFormattingProvider = false
--             client.server_capabilities.documentRangeFormattingProvider = false
--
--             local function buf_set_option(...)
--                 vim.api.nvim_buf_set_option(bufnr, ...)
--             end
--
--             buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
--
--             require("lsp-inlayhints").on_attach(client, bufnr)
--         end
--
--     })
-- end
lspconfig.tailwindcss.setup({})
lspconfig.sumneko_lua.setup({
    settings = {
        Lua = {diagnostics = {globals = {'vim', 'bit', 'packer_plugins'}}}
    }
})
lspconfig.cssls.setup({})
lspconfig.jsonls.setup({})
-- lspconfig.vuels.setup({})
lspconfig.volar.setup({
    -- init_options = {languageFeatures = {diagnostics = false}},
    -- settings = {init_options = {languageFeatures = {diagnostics = false}}},
    -- settings =
    --
    -- k    on_new_config = function(new_config)
    --         -- new_config.init_options.typescript.tsdk =
    -- on_new_config = function(new_config, new_root_dir)
    -- new_config.init_options.languageFeatures.diagnostics = false
    -- end,
    -- init_options = {languageFeatures = {diagnostics = false}},
    filetypes = {
        'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue',
        'json'
    }
})
lspconfig.pyright.setup({})

local on_eslint_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = true
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
end

lspconfig.eslint.setup({on_attach = on_eslint_attach})
-- lspconfig.eslint.setup({})
local saga = require("lspsaga")

saga.init_lsp_saga({
    code_action_lightbulb = {enable = false},
    symbol_in_winbar = {in_custom = true}
})
-- 'jose-elias-alvarez/typescript.nvim' 'jose-elias-alvarez/typescript.nvim' 'jose-elias-alvarez/typescript.nvim' 'jose-elias-alvarez/typescript.nvim'
local function get_file_name(include_path)
    local file_name = require('lspsaga.symbolwinbar').get_file_name()
    if vim.fn.bufname '%' == '' then return '' end
    if include_path == false then return file_name end
    -- Else if include path: ./lsp/saga.lua -> lsp > saga.lua
    local sep = vim.loop.os_uname().sysname == 'Windows' and '\\' or '/'
    local path_list = vim.split(string.gsub(vim.fn.expand '%:~:.:h', '%%', ''),
                                sep)
    local file_path = ''
    for _, cur in ipairs(path_list) do
        file_path =
            (cur == '.' or cur == '~') and '' or file_path .. cur .. ' ' ..
                '%#LspSagaWinbarSep#>%*' .. ' %*'
    end
    return file_path .. file_name
end

local function config_winbar_or_statusline()
    local exclude = {
        ['terminal'] = true,
        ['toggleterm'] = true,
        ['prompt'] = true,
        ['NvimTree'] = true,
        ['help'] = true
    } -- Ignore float windows and exclude filetype
    if vim.api.nvim_win_get_config(0).zindex or exclude[vim.bo.filetype] then
        vim.wo.winbar = ''
    else
        local ok, lspsaga = pcall(require, 'lspsaga.symbolwinbar')
        local sym
        if ok then sym = lspsaga.get_symbol_node() end
        local win_val = ''
        win_val = get_file_name(true) -- set to true to include path
        if sym ~= nil then win_val = win_val .. sym end
        -- vim.wo.winbar = win_val
        -- if work in statusline
        vim.wo.stl = win_val
    end
end

local events = {'BufEnter', 'BufWinEnter', 'CursorMoved'}

vim.api.nvim_create_autocmd(events, {
    pattern = '*',
    callback = function() config_winbar_or_statusline() end
})

vim.api.nvim_create_autocmd('User', {
    pattern = 'LspsagaUpdateSymbol',
    callback = function() config_winbar_or_statusline() end
})

-- P
--
--
--
