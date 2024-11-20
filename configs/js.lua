local plug = {}

function plug.load_stage()
    -- Yes theres none
end

function plug.load_after()
	lspconfig.ts_ls.setup({
	    capabilities = capabilities,
        on_attach = on_attach,
	})

    lspconfig.eslint.setup({
		capabilities = capabilities,
        on_attach = on_attach,

        settings = {
            eslint = {
                enable = true,
                packageManager = 'npm',
            }
        }
	})

    table.insert(null_sources, require("none-ls.code_actions.eslint_d"))
    table.insert(null_sources, require("none-ls.formatting.eslint_d"))

	table.insert(null_sources, require("none-ls.diagnostics.eslint_d").with({
        diagnostics_formatting = "[eslint] #{m}\n(#{c})"
    }))
end

return plug
