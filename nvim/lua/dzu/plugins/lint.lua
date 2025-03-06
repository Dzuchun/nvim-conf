local function names(linters_by_ft, field)
    local res = {}
    for ft, spec in pairs(linters_by_ft) do
        if spec[field] ~= nil then
            res[ft] = spec[field]
        else
            res[ft] = spec
        end
    end
    return res
end

local function config()
    local is_ok, lint = pcall(require, 'lint')
    if not is_ok then
        vim.notify("Failed to setup lint");
        return;
    end

    local web_linters = { mason = { 'biome' }, lint = { "biomejs" } }

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
    for _, lints in pairs(names(linters_by_ft, "mason")) do
        for _, lnt in pairs(lints) do
            ADDITIONAL_MASON_TOOLS[lnt] = lnt
        end
    end

    lint.linters_by_ft = names(linters_by_ft, "lint")

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
