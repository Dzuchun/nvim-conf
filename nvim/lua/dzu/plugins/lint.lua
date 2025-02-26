local function config()
    local is_ok, lint = pcall(require, 'lint')
    if not is_ok then
        vim.notify("Failed to setup lint");
        return;
    end

    local web_linters = { 'biome' }


    local linters_by_ft = {
        javascript = web_linters,
        javascriptreact = web_linters,
        typescript = web_linters,
        typescriptreact = web_linters,
        json = web_linters,
        haskell = { 'hlint' },
        lhaskell = { 'hlint' },
        cabal = { 'hlint' },
        dockerfile = { "hadolint" },
    }
    -- add to tool list
    for _, lints in pairs(linters_by_ft) do
        for _, lnt in pairs(lints) do
            ADDITIONAL_MASON_TOOLS[lnt] = lnt
        end
    end

    lint.linters_by_ft = linters_by_ft

    -- autolint on save
    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
        pattern = { "*.js", "*.ts", "*.jsx", "*.tsx", "*.json", "*.hs", "*Dockerfile*" },
        callback = function(_)
            lint.try_lint()
        end,
    })
end

return {
    "mfussenegger/nvim-lint",
    config = config,
    lazy = false,
}
