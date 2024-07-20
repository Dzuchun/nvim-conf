-- CRED: nvim from scratch - https://github.com/LunarVim/Neovim-from-scratch/blob/06-LSP/lua/user/lsp/handlers.lua

function config()
    local is_ok, _ = pcall(require, 'dzu.lsp')
    if not is_ok then
        vim.notify("failed to setup lsp")
        return
    end
end

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        {
            "hrsh7th/cmp-nvim-lsp",
            lazy = false,
        }, -- lsp suggestions
        -- "jose-elias-alvarez/null-ls.nvim",
        -- "jay-babu/mason-null-ls.nvim",
    },
    config = config,
    lazy = false,
}
