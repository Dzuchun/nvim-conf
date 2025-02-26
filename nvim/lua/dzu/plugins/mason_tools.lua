local function config()
    local is_ok, installer = pcall(require, 'mason-tool-installer')
    if not is_ok then
        vim.notify('failed to find mason tool installer')
        return
    end
    local tools = {}
    for _, tool in pairs(ADDITIONAL_MASON_TOOLS) do
        table.insert(tools, tool)
    end
    installer.setup({ ensure_installed = tools })
end

return {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = false,
    config = config,
    dependencies = {
        -- run after formatters
        "stevearc/conform.nvim",
        -- and linters
        "mfussenegger/nvim-lint",
    }
}
