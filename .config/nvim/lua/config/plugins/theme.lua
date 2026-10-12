return {
    -- Lua

    -- {
    --     'olivercederborg/poimandres.nvim',
    --     lazy = false,
    --     priority = 1000,
    --     config = function()
    --         require('poimandres').setup {
    --             -- leave this setup function empty for default config
    --             -- or refer to the configuration section
    --             -- for configuration options
    --         }
    --     end,
    --
    --     -- optionally set the colorscheme within lazy config
    --     init = function()
    --         vim.cmd("colorscheme poimandres")
    --     end
    -- }
    {
        "echasnovski/mini.base16",
        version = false,
        priority = 1000,
        config = function()
            require('mini.base16').setup({
                -- palette = {
                --     base00 = "#000000", -- Default Background
                --     base01 = "#000000", -- Lighter Background (status bars, line numbers, etc.)
                --     base02 = "#303340", -- Selection Background
                --     base03 = "#506477", -- Comments, Invisibles, Line Highlighting
                --     base04 = "#7390AA", -- Dark Foreground (status bars)
                --     base05 = "#E4F0FB", -- Default Foreground, Caret, Delimiters, Operators
                --     base08 = "#D0679D", -- Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
                --     base09 = "#FCC5E9", -- Integers, Boolean, Constants, XML Attributes, Markup Link Url
                --     base0B = "#5FB3A1", -- Strings, Inherited Class, Markup Code, Diff Inserted
                --     base0C = "#5DE4C7", -- Support, Regular Expressions, Escape Characters, Markup Quotes
                -- },
                --     base00 = "#000000", -- Default Background
                --     base01 = "#000000", -- Lighter Background (status bars, line numbers, etc.)
                --     base02 = "#303340", -- Selection Background
                --     base03 = "#506477", -- Comments, Invisibles, Line Highlighting
                --     base04 = "#7390AA", -- Dark Foreground (status bars)
                --     base05 = "#E4F0FB", -- Default Foreground, Caret, Delimiters, Operators
                --     base06 = "#FAE4FC", -- Light Foreground (Not often used)
                --     base07 = "#FFFFFF", -- Light Background (Not often used)
                --     base08 = "#D0679D", -- Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
                --     base09 = "#FCC5E9", -- Integers, Boolean, Constants, XML Attributes, Markup Link Url
                --     base0A = "#FFFAC2", -- Classes, Markup Bold, Search Text Background
                --     base0B = "#5FB3A1", -- Strings, Inherited Class, Markup Code, Diff Inserted
                --     base0C = "#5DE4C7", -- Support, Regular Expressions, Escape Characters, Markup Quotes
                --     base0D = "#89DDFF", -- Functions, Methods, Attribute IDs, Headings
                --     base0E = "#A6ACCD", -- Keywords, Storage, Selector, Markup Italic, Diff Changed
                --     base0F = "#767C9D", -- Deprecated, Opening/Closing Embedded Language Tags
                --     lua require('base16-colorscheme').setup({
                -- \ base00 = '#000000', base01 = '#121212', base02 = '#222222', base03 = '#333333',
                -- \ base04 = '#999999', base05 = '#c1c1c1', base06 = '#999999', base07 = '#c1c1c1',
                -- \ base08 = '#5f8787', base09 = '#aaaaaa', base0A = '#a06666', base0B = '#dd9999',
                -- \ base0C = '#aaaaaa', base0D = '#888888', base0E = '#999999', base0F = '#444444'
                -- \})

                -- kali blue #0080fe
                -- base08 = "#fe0100", -- Red
                -- 29c1aa

                palette = {
                    base00 = "#0c0e13", -- Background (Ghostty background)
                    -- base01 = "#161a22", -- Lighter Background (palette 0)
                    base01 = "#0c0e13", -- Lighter Background (palette 0)
                    base02 = "#4d3028", -- Selection Background
                    base03 = "#606060", -- Comments (palette 8)
                    base04 = "#8a8a8a", -- Dark Foreground (status bars)
                    base05 = "#eeeeee", -- Default Foreground
                    base06 = "#eeeeee", -- Light Foreground
                    base07 = "#ffffff", -- Lightest Foreground (palette 15)
                    base08 = "#e06c75", -- Variables, Diff Deleted (red)
                    base09 = "#EE7948", -- Constants, Numbers (orange)
                    base0A = "#e5c07b", -- Classes, Search (yellow)
                    base0B = "#6ba1e6", -- Strings (blue)
                    base0C = "#56b6c2", -- Regex, Escape (cyan)
                    base0D = "#EE7948", -- Functions (orange)
                    base0E = "#EC5B2B", -- Keywords (Cloudflare orange)
                    base0F = "#f5a07a", -- Deprecated (bright orange)
                },
                use_cterm = true,       -- Optional: enable for better terminal color support
            })
            --     highlight Normal guibg=NONE ctermbg=NONE
            --     highlight NormalNC guibg=NONE ctermbg=NONE
            --     highlight LineNr guibg=NONE ctermbg=NONE
            --     highlight CursorLineNr guibg=NONE ctermbg=NONE
            --     highlight SignColumn guibg=NONE ctermbg=NONE
            --     highlight FoldColumn guibg=NONE ctermbg=NONE
            vim.cmd [[
                highlight StatusLine guibg=NONE
                highlight StatusLineNC guibg=NONE
                highlight TreesitterContextBottom gui=underline
            ]]
        end,

    },
}
