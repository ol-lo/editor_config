local function filter_diagnostic(ns, bufnr, diag, opts, orig_handler)
    local filtered = {}
    for _, v in ipairs(diag) do
        if v.source ~= "ts" then filtered[#filtered + 1] = v end
    end
    orig_handler.show(ns, bufnr, filtered, opts)
end

local orig_signs_handler = vim.diagnostic.handlers.signs
vim.diagnostic.handlers.signs = {
    show = function(ns, bufnr, diag, opts)
        filter_diagnostic(ns, bufnr, diag, opts, orig_signs_handler)
    end,
    hide = function(ns, bufnr) orig_signs_handler.hide(ns, bufnr) end
}

local orig_virt_handler = vim.diagnostic.handlers.virtual_text
vim.diagnostic.handlers.virtual_text = {
    show = function(ns, bufnr, diag, opts)
        filter_diagnostic(ns, bufnr, diag, opts, orig_virt_handler)
    end,
    hide = function(ns, bufnr) orig_virt_handler.hide(ns, bufnr) end
}
P = function(...) print(vim.inspect(...)); end
