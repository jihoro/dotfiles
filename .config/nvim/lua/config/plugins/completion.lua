return {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = {
        'rafamadriz/friendly-snippets',
        -- "giuxtaposition/blink-cmp-copilot",
    },

    -- use a release tag to download pre-built binaries
    version = 'v0.*',
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        -- 'default' for mappings similar to built-in completion
        -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
        -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
        -- see the "default configuration" section below for full documentation on how to define
        -- your own keymap.
        keymap = { preset = 'default' },

        appearance = {
            -- Sets the fallback highlight groups to nvim-cmp's highlight groups
            -- Useful for when your theme doesn't support blink.cmp
            -- will be removed in a future release
            use_nvim_cmp_as_default = true,
            -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- Adjusts spacing to ensure icons are aligned
            nerd_font_variant = 'mono',
            -- -- Blink does not expose its default kind icons so you must copy them all (or set your custom ones) and add Copilot
            -- kind_icons = {
            --     Copilot = "",
            --     Text = '󰉿',
            --     Method = '󰊕',
            --     Function = '󰊕',
            --     Constructor = '󰒓',
            --
            --     Field = '󰜢',
            --     Variable = '󰆦',
            --     Property = '󰖷',
            --
            --     Class = '󱡠',
            --     Interface = '󱡠',
            --     Struct = '󱡠',
            --     Module = '󰅩',
            --
            --     Unit = '󰪚',
            --     Value = '󰦨',
            --     Enum = '󰦨',
            --     EnumMember = '󰦨',
            --
            --     Keyword = '󰻾',
            --     Constant = '󰏿',
            --
            --     Snippet = '󱄽',
            --     Color = '󰏘',
            --     File = '󰈔',
            --     Reference = '󰬲',
            --     Folder = '󰉋',
            --     Event = '󱐋',
            --     Operator = '󰪚',
            --     TypeParameter = '󰬛',
            -- },
        },
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
            -- providers = {
            --     codeium = { name = 'Codeium', module = 'codeium.blink', async = true },
            -- },
        },
        -- sources = {
        --     default = { "lsp", "path", "snippets", "buffer", "copilot" },
        --     providers = {
        --         copilot = {
        --             name = "copilot",
        --             module = "blink-cmp-copilot",
        --             score_offset = 100,
        --             async = true,
        --             transform_items = function(_, items)
        --                 local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
        --                 local kind_idx = #CompletionItemKind + 1
        --                 CompletionItemKind[kind_idx] = "Copilot"
        --                 for _, item in ipairs(items) do
        --                     item.kind = kind_idx
        --                 end
        --                 return items
        --             end,
        --         },
        --     },
        -- },
        completion = {
            menu = {
                border = "rounded"
            },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 100,
                window = {
                    border = "rounded"
                },
            },
            ghost_text = {
                enabled = false
            },
            trigger = {
                prefetch_on_insert = true,
                show_on_trigger_character = true,
            },
        },
        signature = {
            enabled = true,
            window = {
                border = "rounded"
            },
        },
    },
}
