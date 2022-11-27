local git_icons = {
    unstaged = "",
    staged = "",
    unmerged = "",
    renamed = "➜",
    untracked = "",
    deleted = "",
    ignored = "◌"
}
require("nvim-tree").setup({
    renderer = {icons = {show = {file = false}, glyphs = {git = git_icons}}},
    update_focused_file = {update_cwd = true}
})
