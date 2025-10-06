local function config()
    local is_ok, jdtls = pcall(require, "jdtls")
    if not is_ok then
        vim.notify "Couldn't load jdtls (java additional LSP plugin)"
        return
    end
end

return {
    "mfussenegger/nvim-jdtls",
    config = config,
    lazy = true,
}
