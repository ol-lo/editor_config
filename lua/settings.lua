local options = {
    number = true,
    relativenumber = true,
    ignorecase = true,
    title = true,
    shiftwidth = 4,
    tabstop = 4,
    smartindent = true,
    background = "light",
    completeopt = {'menuone', 'noselect', 'noinsert'},
    shortmess = vim.opt.shortmess + {c = true},
    updatetime = 300,
    splitright = true,
    splitbelow = true
}

for k, v in pairs(options) do vim.opt[k] = v end

vim.g["floaterm_wintype"] = "split"
vim.g["floaterm_height"] = 0.3
vim.g["floaterm_title"] = '$1/$2'
-- vim.g["floaterm_autohide"] = 0
vim.g["floaterm_autoclose"] = 0
-- Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force to select one from the menu
-- shortness: avoid showing extra messages when using completion
-- updatetime: set updatetime for CursorHold
