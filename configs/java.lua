local plug = {}

local resolve_jdtls_command = function()
    local install_path = require("mason-registry").get_package("jdtls"):get_install_path()
    local workspace_dir = vim.fn.stdpath("data") .. "/site/java/workspace-root/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

    return {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-javaagent:" .. install_path .. "/lombok.jar",
        "-Xms1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",
        "-jar",
        vim.fn.glob(install_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
        "-configuration",
        install_path .. "/config_linux",
        "-data",
        workspace_dir,
    }
end

function plug.load_stage()
    table.insert(plugins, {
        -- original source 1: https://github.com/isaksamsten/nvim-config/blob/bc67ae5decbbdcda3f9b13d5c61d22ee0896debc/lua/plugins/lsp.lua#L42
        -- original source 2: https://www.reddit.com/r/neovim/comments/12ubxfj/need_help_with_configuring_jdtls/
        "mfussenegger/nvim-jdtls",
        ft = "java",
        opts = {
            root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" },
        },
        config = function(_, opts)
            local resolve_opts = function()
                local root_dir = require("jdtls.setup").find_root(opts.root_markers)

                if not root_dir or root_dir == "" then
                    print("Cannot find project root. Make sure your project has one of these files: " .. opts.root_markers)
                    return nil
                end

                return {
                    cmd = resolve_jdtls_command(),
                    root_dir = root_dir,
                }
            end

            vim.api.nvim_create_autocmd("Filetype", {
                pattern = "java", -- autocmd to start jdtls
                callback = function()
                    local start_opts = resolve_opts()
                    if start_opts and start_opts.root_dir and start_opts.root_dir ~= "" then
                        require("jdtls").start_or_attach(start_opts)
                    end
                end,
            })
        end,
    })
end

function plug.load_after()
    lspconfig.jdtls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        cmd = resolve_jdtls_command(),
        root_dir = lspconfig.util.root_pattern(".git", "pom.xml", "build.gradle"),
        settings = {
            java = {
                configuration = {
                    updateBuildConfiguration = 'automatic',
                },
                compile = {
                    enabled = true,
                },
            },
        },
    })
end

return plug
