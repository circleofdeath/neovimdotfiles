local plug = {}

function plug.load_stage()
    table.insert(plugins, { "cdelledonne/vim-cmake" })
end

function plug.load_after()
    lspconfig.cmake.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        command = "cmake-language-server",
    })

    lspconfig.clangd.setup({
        capabilities = capabilities,
        on_attach = on_attach,
    })

    table.insert(null_sources, null_ls.builtins.formatting.clang_format)
    vim.keymap.set("n", "<leader>cg", ":CMakeGenerate<CR>", {})
    vim.keymap.set("n", "<leader>cb", ":CMakeBuild<CR>", {})
end

return plug
