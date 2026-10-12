return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        branch = 'main',
        build = ":TSUpdate",
        config = function()
            require 'nvim-treesitter'.setup {}
            require 'nvim-treesitter'.install { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "go", "typescript", "helm", "yaml", "toml", "terraform", "dockerfile", "python", "rust" }
            -- require('nvim-treesitter.configs').setup({
            --     -- A list of parser names, or "all" (the listed parsers MUST always be installed)
            --     ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "go", "typescript", "helm", "yaml", "toml", "terraform", "dockerfile" },
            --
            --     -- Install parsers synchronously (only applied to `ensure_installed`)
            --     sync_install = false,
            --
            --     auto_install = false,
            --     highlight = {
            --         enable = true,
            --         -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
            --         disable = function(lang, buf)
            --             local max_filesize = 100 * 1024 -- 100 KB
            --             local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            --             if ok and stats and stats.size > max_filesize then
            --                 return true
            --             end
            --         end,
            --         additional_vim_regex_highlighting = false,
            --     },
            -- })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = 'main',
        config = function()
            require("nvim-treesitter-textobjects").setup {}
            vim.keymap.set({ "x", "o" }, "ar", function()
                require "nvim-treesitter-textobjects.select".select_textobject("@parameter.outer", "textobjects")
            end)
            vim.keymap.set({ "x", "o" }, "ir", function()
                require "nvim-treesitter-textobjects.select".select_textobject("@parameter.inner", "textobjects")
            end)
            vim.keymap.set({ "x", "o" }, "af", function()
                require "nvim-treesitter-textobjects.select".select_textobject("@function.outer", "textobjects")
            end)
            vim.keymap.set({ "x", "o" }, "if", function()
                require "nvim-treesitter-textobjects.select".select_textobject("@function.inner", "textobjects")
            end)
            -- require 'nvim-treesitter.configs'.setup {
            --     textobjects = {
            --         select = {
            --             enable = true,
            --             lookahead = true,
            --             keymaps = {
            --                 ["ar"] = "@parameter.outer", -- around parameter
            --                 ["ir"] = "@parameter.inner", -- inside parameter
            --             },
            --             include_surrounding_whitespace = true,
            --         },
            --     },
            -- }
        end
    },
    -- {
    --     "nvim-treesitter/nvim-treesitter-context",
    --     dependencies = { "nvim-treesitter/nvim-treesitter" },
    --     config = function()
    --         require 'treesitter-context'.setup {
    --             enable = true,            -- Enable this plugin (Can be enabled/disabled later via commands)
    --             multiwindow = false,      -- Enable multiwindow support.
    --             max_lines = 0,            -- How many lines the window should span. Values <= 0 mean no limit.
    --             min_window_height = 0,    -- Minimum editor window height to enable context. Values <= 0 mean no limit.
    --             line_numbers = true,
    --             multiline_threshold = 20, -- Maximum number of lines to show for a single context
    --             trim_scope = 'outer',     -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
    --             mode = 'cursor',          -- Line used to calculate context. Choices: 'cursor', 'topline'
    --             -- Separator between context and content. Should be a single character string, like '-'.
    --             -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
    --             separator = nil,
    --             zindex = 20,     -- The Z-index of the context window
    --             on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
    --         }
    --     end,
    -- },
}
