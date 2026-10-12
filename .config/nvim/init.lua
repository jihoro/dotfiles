vim.lsp.set_log_level(vim.log.levels.OFF)

require("config.lazy")
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.wo.number = true
vim.wo.relativenumber = true
vim.opt.clipboard = 'unnamedplus'

-- keymaps
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })

-- vim.keymap.set("n", "<C-d>", function()
--     vim.cmd("normal! " .. math.floor(vim.api.nvim_win_get_height(0) / 4) .. "jzz")
-- end, { noremap = true, silent = true })
-- vim.keymap.set("n", "<C-u>", function()
--     vim.cmd("normal! " .. math.floor(vim.api.nvim_win_get_height(0) / 4) .. "kzz")
-- end, { noremap = true, silent = true })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set("n", "<C-n>", "<cmd>cnext<CR>")
vim.keymap.set("n", "<C-p>", "<cmd>cprev<CR>")

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    end
})

-- enable virtual / ghost text
vim.diagnostic.config({
    virtual_text = true,
    float = { border = "rounded" }
})

vim.opt.wrap = false
vim.o.ignorecase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true
vim.o.guicursor = ""

-- fold settings
vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldtext = ""
vim.opt.foldcolumn = "0"
vim.opt.fillchars:append({ fold = " " })

vim.api.nvim_create_autocmd('FileType', {
    pattern = '*',
    callback = function() pcall(vim.treesitter.start) end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "yaml", "yml" },
    callback = function()
        vim.opt_local.expandtab = true
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
        vim.opt_local.softtabstop = 2
    end,
})
