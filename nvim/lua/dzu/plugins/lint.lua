function config()
    local is_ok, lint = pcall(require, 'lint')
    if not is_ok then
        vim.notify("Failed to setup lint");
        return;
    end

    local web_linters = { 'biomejs' }
    lint.linters_by_ft = {
        javascript = web_linters,
        javascriptreact = web_linters,
        typescript = web_linters,
        typescriptreact = web_linters,
        json = web_linters,
    }

    -- autolint on save
    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
        pattern = { "*.js", "*.ts", "*.jsx", ".tsx", "*.json" },
        callback = function(ev)
            lint.try_lint()
        end,
    })
end

return {
    "mfussenegger/nvim-lint",
    config = config,
    lazy=false,
}
