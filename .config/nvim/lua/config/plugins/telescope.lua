return {
    'nvim-telescope/telescope.nvim',
    branch = 'master',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    config = function()
        require('telescope').setup {
            pickers = {
                colorscheme = {
                    enable_preview = true,
                },
                find_files = {
                    -- theme = "dropdown",
                },
                live_grep = {
                    -- theme = "dropdown",
                    entry_maker = function(entry)
                        local filename, lnum, col, text = string.match(entry, "([^:]+):(%d+):(%d+):(.*)")
                        return {
                            value = entry,
                            ordinal = filename .. " " .. text,
                            display = filename .. ":" .. lnum, -- Only show filename and line number
                            filename = filename,
                            lnum = tonumber(lnum),
                            col = tonumber(col),
                            text = text,
                        }
                    end,
                },
                lsp_references = {
                    -- theme = "dropdown",
                    entry_maker = function(entry)
                        local filename = entry.filename or entry.uri
                        local lnum = entry.lnum
                        return {
                            value = entry,
                            ordinal = filename .. " " .. (entry.text or ""), -- Use filename + text for filtering
                            display = filename .. ":" .. lnum,               -- Only show filename and line number
                            filename = filename,
                            lnum = lnum,
                            col = entry.col or 1, -- Optional: You can include column if necessary
                            text = entry.text,    -- Reference text (optional)
                        }
                    end,
                },
            },
        }
        local builtin = require('telescope.builtin')
        vim.keymap.set("n", "<leader>pf", builtin.find_files)
        vim.keymap.set("n", "<leader>fh", builtin.help_tags)
        vim.keymap.set('n', '<leader>ps', builtin.live_grep)
        vim.keymap.set("n", "<leader>gr", builtin.lsp_references)
        vim.keymap.set("n", "<leader>pg", function()
            vim.ui.input({ prompt = "Glob pattern (e.g., *.js or *config*): " }, function(glob)
                if glob and glob ~= "" then
                    require("telescope.builtin").live_grep({
                        additional_args = function()
                            return { "--glob=" .. glob }
                        end
                    })
                end
            end)
        end, { desc = "Live grep in files matching a glob pattern" })
    end
}
