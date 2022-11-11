require('impatient')

require("settings")
require("plugins")
-- require("color")
require("lsp")
require("bqf").setup()
require("nvim-autopairs").setup()
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
vim.g.zenbones = { lightness = "bright" }
vim.cmd([[set background=light]])
vim.cmd([[colorscheme zenwritten]])

-- vim.cmd([[colorscheme nordbones]])
-- -- vim.g.zenbones = { lightness = "bright" }
-- vim.cmd([[set background=dark]])

vim.cmd([[set termguicolors]])
require("mason").setup()
-- require("zenbones").load()
require('nvim_comment').setup()
if vim.g["neovide"] then

    vim.g["neovide_remember_window_size"] = "v:true"

    vim.opt["guifont"] = "JetBrains Mono:h7.5"
    -- Put anything you want to happen only in Neovide here"k
end
-- vim.o.background = "dark" -- or "light" for light mode
-- vim.cmd([[colorscheme gruvbox]])

local null_ls = require("null-ls")
local util = require("vim.lsp.util")
null_ls.setup({
    sources = {

        null_ls.builtins.formatting.lua_format
        -- null_ls.builtins.formatting.rustfmt
    },

    on_attach = function(client, bufnr)
        vim.keymap.set('n', '<C-i>',
                       function() vim.lsp.buf.formatting_sync(nil, 10000) end,
                       {buffer = bufnr, silent = true})
    end
})
local map = vim.api.nvim_set_keymap

-- map("n", "<space-f>", [[<cmd>lua vim.lsp.buf.formatting_sync(nil, 10000)<cr>]], { noremap = true, silent = true })

require("nvim-tree").setup()

require'hop'.setup {keys = 'etovxqpdygfblzhckisuran'}
-- null_ls.setup {

      -- Hover actions
--[[local rt = require('rust-tools')
rt.setup({    
	server = {on_attach = function(_, bufnr)
      -- Hover actions
    vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
  end
  ,},})]]
--
--[[local cmp = require('cmp')
cmp.setup({
  -- Enable LSP snippetou
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },
  -- Installed sources:
  sources = {
    { name = 'path' },                              -- file paths
    { name = 'nvim_lsp', keyword_length = 3 },      -- from language server
    { name = 'nvim_lsp_signature_help'},            -- display function signatures with current parameter emphasized
    { name = 'nvim_lua', keyword_length = 2},       -- complete neovim's Lua runtime API such vim.lsp.*
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
              buffer = 'Ω',
              path = '🖫',
          }
          item.menu = menu_icon[entry.source.name]
          return item
      end,
  },
})
]]
--
