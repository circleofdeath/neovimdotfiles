local config_dir = vim.fn.stdpath('config')
package.path = package.path .. ";" .. config_dir .. "/?.lua"

vim.cmd('set expandtab')
vim.cmd('set tabstop=4')
vim.cmd('set softtabstop=4')
vim.cmd('set shiftwidth=4')

vim.opt.signcolumn = "yes"
vim.g.mapleader = " "
vim.wo.number = true
vim.wo.relativenumber = true
vim.opt.termguicolors = true

vim.cmd [[
    autocmd CursorHold,CursorHoldI,CursorMoved,CursorMovedI,FocusLost * silent! :w
    autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
    autocmd InsertLeave * lua vim.diagnostic.open_float(nil, { focusable = false })
    autocmd CursorMovedI * lua vim.diagnostic.show()
    autocmd CursorMoved * lua vim.diagnostic.show()
    set mouse=
]]

local ides = {}

for _, arg in ipairs(vim.fn.argv()) do
    if(arg == "java") then
        table.insert(ides, require("configs.java"))
    end

    if(arg == "clike") then
        table.insert(ides, require("configs.clike"))
    end

    if(arg == "js") then
        table.insert(ides, require("configs.js"))
    end
end

require("baseconfig.lazy")
require("baseconfig.plugins")

for _, ide in ipairs(ides) do
    ide.load_stage()
end

require("lazy").setup(plugins, opts)
require("baseconfig.lang")
require("baseconfig.keys")

require("catppuccin").setup()
vim.cmd.colorscheme("catppuccin")

for _, ide in ipairs(ides) do
    ide.load_after()
end

setup_null()
