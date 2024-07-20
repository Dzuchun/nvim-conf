-- setup LSPs
local is_ok, _ = pcall(require, "dzu.lsp.mason")
if not is_ok then
    vim.notify("failed to setup Mason")
    return
end

-- format code on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = {
        "*.rs", -- rust sources
        "*.py", -- python sources
        "*.js", -- javascript sources
    },
    callback = function(ev)
        vim.lsp.buf.format()
    end,
})
