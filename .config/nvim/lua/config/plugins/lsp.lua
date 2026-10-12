return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            'saghen/blink.cmp',
            {
                "folke/lazydev.nvim",
                ft = "lua", -- only load on lua files
                opts = {
                    library = {
                        -- See the configuration section for more details
                        -- Load luvit types when the `vim.uv` word is found
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            },
        },
        config = function()
            local capabilities = require('blink.cmp').get_lsp_capabilities()

            -- New Neovim 0.11+ LSP config
            vim.lsp.enable('lua_ls')
            vim.lsp.config('lua_ls', {
                capabilities = capabilities
            })

            vim.lsp.enable('rust_analyzer')
            vim.lsp.config('rust_analyzer', {
                capabilities = capabilities
            })

            vim.lsp.enable('gopls')
            vim.lsp.config('gopls', {
                capabilities = capabilities
            })

            vim.lsp.enable('basedpyright')
            vim.lsp.config('basedpyright', {
                capabilities = capabilities,
                settings = {
                    basedpyright = {
                        analysis = {
                            typeCheckingMode = "basic",
                        },
                        disableOrganizeImports = true,
                    },
                },
            })
            vim.lsp.enable('ruff')
            vim.lsp.config('ruff', {
                capabilities = capabilities,
                on_attach = function(client)
                    client.server_capabilities.hoverProvider = false
                end,
            })
            -- vim.lsp.config('tsserver', {
            --   capabilities = capabilities
            -- })

            vim.lsp.enable('helm_ls')
            vim.lsp.config('helm_ls', {
                capabilities = capabilities
            })

            vim.lsp.enable('yamlls')
            vim.lsp.config('yamlls', {
                capabilities = capabilities,
                settings = {
                    yaml = {
                        format = {
                            enable = false,
                            singleQuote = true,
                            bracketSpacing = false,
                        },
                        editor = {
                            tabSize = 2,
                            insertSpaces = true,
                            formatOnType = true
                        },
                    },
                },
            })

            vim.lsp.enable('terraformls')
            vim.lsp.config('terraformls', {
                capabilities = capabilities,
                on_attach = function(client)
                    client.server_capabilities.documentFormattingProvider = false
                end
            })

            vim.lsp.enable('yls')
            vim.lsp.config('yls', {
                capabilities = capabilities
            })

            vim.api.nvim_create_autocmd('LspAttach', {
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if not client then return end

                    -- if client:supports_method('textDocument/implementation', 0) then
                    --   -- Create a keymap for vim.lsp.buf.implementation
                    -- end
                    --
                    -- if client:supports_method('textDocument/completion') then
                    --   -- Enable auto-completion
                    --   vim.lsp.completion.enable(true, client.id, args.buf, {autotrigger = true})
                    -- end

                    if client:supports_method('textDocument/formatting') then
                        -- Format the current buffer on save
                        vim.api.nvim_create_autocmd('BufWritePre', {
                            buffer = args.buf,
                            callback = function()
                                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
                            end,
                        })
                    end
                end,
            })

            vim.lsp.util.open_floating_preview = (function(original)
                return function(contents, syntax, opts, ...)
                    opts = opts or {}
                    opts.border = opts.border or "rounded"
                    return original(contents, syntax, opts, ...)
                end
            end)(vim.lsp.util.open_floating_preview)
        end,
    },
    {
        "crispgm/nvim-go",
        config = function()
            require('go').setup({
                auto_format = false,
                auto_lint = false,
                linter = 'golangci-lint',
                formatter = 'gofumpt',
                tags_options = {},
            })
            vim.keymap.set("n", "<leader>ie", "<cmd>GoIfErr<CR>")
        end
    },
    {
        "pmizio/typescript-tools.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },

        config = function()
            local capabilities = require('blink.cmp').get_lsp_capabilities()
            require("typescript-tools").setup({
                capabilities = capabilities,
            })
        end,
    },

}
