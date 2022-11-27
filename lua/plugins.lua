vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function()
    use("wbthomason/packer.nvim")

    use 'lewis6991/impatient.nvim'
    use {'nvim-lua/plenary.nvim'}
    use {'kyazdani42/nvim-web-devicons'}

    -- themes
    use {
        "mcchrish/zenbones.nvim",
        -- Optionally install Lush. Allows for more configuration or extending the colorscheme
        -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
        -- In Vim, compat mode is turned on as Lush only works in Neovim.
        requires = "rktjmp/lush.nvim"
    }
    use 'nvim-treesitter/nvim-treesitter'
    use("neovim/nvim-lspconfig")
    use("ray-x/lsp_signature.nvim")
    use 'simrat39/rust-tools.nvim'
    use {'jose-elias-alvarez/typescript.nvim'}

    use({"glepnir/lspsaga.nvim", branch = "main"})
    use('rust-lang/rust.vim')
    -- cmp
    use('hrsh7th/cmp-vsnip')
    use('hrsh7th/nvim-cmp')
    use('hrsh7th/cmp-nvim-lsp')
    use('hrsh7th/vim-vsnip')
    -- use('hrsh7th/cmp-buffer')
    use('hrsh7th/cmp-path')
    use {'stevearc/dressing.nvim'}
    use("williamboman/mason.nvim")
    use {'williamboman/mason-lspconfig.nvim'}

    use({
        "jose-elias-alvarez/null-ls.nvim",
        requires = {{"nvim-lua/plenary.nvim"}}
    })
    use 'JoosepAlviste/nvim-ts-context-commentstring'
    -- use('terrortylor/nvim-comment')
    use('numToStr/Comment.nvim')
    use 'voldikss/vim-floaterm'
    use('machakann/vim-sandwich')
    use("windwp/nvim-autopairs")
    use {'kevinhwang91/nvim-bqf'}
    use {
        'phaazon/hop.nvim',
        branch = 'v2' -- optional but strongly recommended
        -- you can configure Hop the way you like here; see :h hop-config
    }
    use({
        "nvim-tree/nvim-tree.lua",
        requires = {
            "nvim-tree/nvim-web-devicons" -- optional, for file icons
        }
    })

    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.0',
        -- or                            , branch = '0.1.x',
        requires = {{'nvim-lua/plenary.nvim'}}
    }
end)
