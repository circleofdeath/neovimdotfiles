-- LSP config
capabilities = require("cmp_nvim_lsp").default_capabilities()
lspconfig = require("lspconfig")

function on_attach(client, bufnr)
    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { buffer = bufnr })
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { buffer = bufnr })
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { buffer = bufnr })

    vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        update_in_insert = true,
        severity_sort = true,
    })
end

lspconfig.lua_ls.setup({
	capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            diagnostics = {
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            },
        }
    }
})

lspconfig.jsonls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

-- null-ls
null_ls = require("null-ls")
null_sources = {
    null_ls.builtins.formatting.stylua,
}

function setup_null()
    null_ls.setup({
        sources = null_sources
    })
end

-- treesitter
local config = require("nvim-treesitter.configs")
config.setup({
	auto_install = true,
	sync_install = false,
	highlight = { enable = true },
	indent = { enable = true },
})
