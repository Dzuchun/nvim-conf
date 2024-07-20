function config()
    local is_ok, conform = pcall(require, 'conform')
    if not is_ok then
        vim.notify("failed to setup conform (formatting plugin)")
        return
    end

    -- js/ts fomatters
    local web_fmt = { "biome" };
    -- OPTIONS
    local opts = {
        formatters_by_ft = {
            -- lua = { "stylua" },
            python = { "black" },
            -- Use a sub-list to run only the first available formatter
            javascript = web_fmt,
            javascriptreact = web_fmt,
            typescript = web_fmt,
            typescriptreact = web_fmt,
            json = web_fmt,
        },
        format_on_save = {
            -- These options will be passed to conform.format()
            timeout_ms = 1000,
            lsp_format = "fallback",
        },
        formatters = {
            -- Appears to be ignored
            --[[
            biome = {
                formatter= {
                    enabled= true,
                    formatWithErrors= false,
                    -- ignore = {},
                    attributePosition= "auto",
                    indentStyle= "space",
                    indentWidth= 4,
                    lineWidth= 90,
                    -- lineEnding= "lf"
                },
                organizeImports= {
                    enabled= true
                },
                linter= {
                    enabled= true,
                    rules= {
                        recommended= true
                    }
                }
            }
            ]]--
        },
    }

    conform.setup(opts)
end

return {
    "stevearc/conform.nvim",
    lazy = false,
    config = config,
}
