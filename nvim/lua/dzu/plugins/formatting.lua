local function config()
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
            javascript = web_fmt,
            javascriptreact = web_fmt,
            typescript = web_fmt,
            typescriptreact = web_fmt,
            json = web_fmt,
            haskell = { "fourmolu" },
            lhaskell = { "fourmolu" },
            cabal = { "fourmolu" },
            nix = { "nixfmt" },
            cpp = { "clang-format" },
        },
        format_on_save = {
            -- These options will be passed to conform.format()
            timeout_ms = 1000,
            lsp_format = "fallback",
        },
        formatters = {
            ["clang-format"] = {
                command = "clang-format --style",
            }
        },
    }

    conform.setup(opts)
end

return {
    "stevearc/conform.nvim",
    lazy = false,
    config = config,
}
