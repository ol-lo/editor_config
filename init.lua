-- require('impatient')
require("settings")
require("plugins")
-- require("color")
require("lsp")
require('lsp_fix')
require('mapping')

require("bqf").setup()
require("nvim-autopairs").setup()
require('nvim-treesitter.configs').setup {
    ensure_installed = {
        "lua", "rust", "python", "typescript", "javascript", "vue", "html",
        "json"
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<C-m>",
            node_incremental = "<C-m>",
            scope_incremental = "<TAB>",
            node_decremental = "<S-m>"
        }
    },
    context_commentstring = {enable = true, enable_autocmd = false},
    highlight = {enable = false}
}
-- local rt = require("rust-tools")
-- -- rt.setup({
-- require('onedark').setup {
--     style = 'light'
-- }
-- require('onedark').load()
-- --   server = {
--     on_attach = function(_, bufnr)
-- 	end
-- }})
require('color')
-- require("zenbones").load()
-- require('nvim_comment').setup()
if vim.g["neovide"] then

    vim.g["neovide_remember_window_size"] = "v:true"

    vim.opt["guifont"] = "jetbrains mono:h7.5"
    -- put anything you want to happen only in neovide here"k
end
-- vim.o.background = "dark" -- or "light" for light mode
-- vim.cmd([[colorscheme gruvbox]])
local null_ls = require("null-ls")
local util = require("vim.lsp.util")
null_ls.setup({
    sources = {

        null_ls.builtins.formatting.lua_format,
        null_ls.builtins.formatting.black, 
		-- null_ls.builtins.formatting.eslint_d
        -- null_ls.builtins.formatting.rustfmt
    },

    on_attach = function(client, bufnr)
        vim.keymap.set('n', '<c-i>',
                       function() vim.lsp.buf.formatting_sync(nil, 10000) end,
                       {buffer = bufnr, silent = true})
    end
})
local map = vim.api.nvim_set_keymap

-- map("n", "<space-f>", [[<cmd>lua vim.lsp.buf.formatting_sync(nil, 10000)<cr>]], { noremap = true, silent = true })

require('plugins.ntree')
require'hop'.setup {keys = 'etovxqpdygfblzhckisuran'}
require('Comment').setup {
    pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
}
-- null_ls.setup {

-- hover actions
--[[local rt = require('rust-tools')
rt.setup({    
	server = {on_attach = function(_, bufnr)
      -- hover actions
    vim.keymap.set("n", "<c-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
  end
  ,},})]]
--
--[[local cmp = require('cmp')
cmp.setup({
  -- enable lsp snippetou
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<c-p>'] = cmp.mapping.select_prev_item(),
    ['<c-n>'] = cmp.mapping.select_next_item(),
    -- add tab support
    ['<s-tab>'] = cmp.mapping.select_prev_item(),
    ['<tab>'] = cmp.mapping.select_next_item(),
    ['<c-s-f>'] = cmp.mapping.scroll_docs(-4),
    ['<c-f>'] = cmp.mapping.scroll_docs(4),
    ['<c-space>'] = cmp.mapping.complete(),
    ['<c-e>'] = cmp.mapping.close(),
    ['<cr>'] = cmp.mapping.confirm({
      behavior = cmp.confirmbehavior.insert,
      select = true,
    })
  },
  -- installed sources:
  sources = {
    { name = 'path' },                              -- file paths
    { name = 'nvim_lsp', keyword_length = 3 },      -- from language server
    { name = 'nvim_lsp_signature_help'},            -- display function signatures with current parameter emphasized
    { name = 'nvim_lua', keyword_length = 2},       -- complete neovim's lua runtime api such vim.lsp.*
    { name = 'buffer', keyword_length = 2 },        -- source current buffer
    { name = 'vsnip', keyword_length = 2 },         -- nvim-cmp source for vim-vsnip 
    { name = 'calc'},                               -- source for math calculation
  },
  window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
  },
  formatting = {
      fields = {'menu', 'abbr', 'kind'},
      format = function(entry, item)
          local menu_icon ={
              nvim_lsp = 'λ',
              vsnip = '⋗',
              buffer = 'ω',
              path = '🖫',
          }
          item.menu = menu_icon[entry.source.name]
          return item
      end,
  },
})
]]
--
