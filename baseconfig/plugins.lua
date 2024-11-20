table.insert(plugins, { "catppuccin/nvim", name = "catppuccin", priority = 1000 })
table.insert(plugins, { "Exafunction/codeium.vim" })
table.insert(plugins, { "hrsh7th/cmp-nvim-lsp" })
table.insert(plugins, { "neovim/nvim-lspconfig" })

table.insert(plugins, {
    "nvimtools/none-ls.nvim",
    dependencies = {
		"nvimtools/none-ls-extras.nvim",
	},
})

table.insert(plugins, {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {},
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
})

table.insert(plugins, {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
})

table.insert(plugins, {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate"
})

table.insert(plugins, {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
        "3rd/image.nvim",
    },
    config = function()
        require("neo-tree").setup({
            filesystem = {
                filtered_items = {
                    hide_dotfiles = false,
                    hide_gitignored = false
                },
            },
        })

        vim.cmd("Neotree filesystem reveal right")
    end,
})

table.insert(plugins, {
    "nvim-lualine/lualine.nvim",
    config = function()
        require("lualine").setup({
            options = {
                globalstatus = true,
                icons_enabled = true,
                theme = "onedark",
                component_separators = '|',
                section_separators = ''
            }
        })
    end,
})

table.insert(plugins, {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
        require("mason").setup()
    end,
})

table.insert(plugins, {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
        auto_install = true,
    },
})

table.insert(plugins, {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
        require("telescope").setup({
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown({}),
                },
            },
        })
        require("telescope").load_extension("ui-select")
    end,
})

table.insert(plugins, {
    "goolord/alpha-nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },

    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.startify")
        alpha.setup(dashboard.opts)
    end,
})

table.insert(plugins, {
    "L3MON4D3/LuaSnip",
    dependencies = {
        { "saadparwaiz1/cmp_luasnip" },
        { "rafamadriz/friendly-snippets" },
    },
})

table.insert(plugins, {
    "hrsh7th/nvim-cmp",
    config = function()
        local cmp = require("cmp")
        require("luasnip.loaders.from_vscode").lazy_load()

        cmp.setup({
            snipper = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            window = {},
            mapping = cmp.mapping.preset.insert({
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
            }, {
                { name = "buffer" },
            }),
        })
    end,
})

table.insert(plugins, {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
        "SmiteshP/nvim-navic",
        "nvim-tree/nvim-web-devicons",
    },
    opts = {},
})

table.insert(plugins, {
    "csessh/stopinsert.nvim",
    opts = {},
    config = function()
        require("stopinsert").setup({
            show_popup_msg = false
        })
    end
})

table.insert(plugins, {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
})

table.insert(plugins, {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        require("bufferline").setup({
        })
    end
})
