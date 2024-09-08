local servers = {
    "rust_analyzer", -- rust
    "pyright",       -- has no code formatting
    "marksman",      -- markdown
    "ts_ls",         -- js, ts, tsx
    "clangd",        -- C
    "lua_ls",
    "hls",
}

-- lspconfig needs tsserver, while mason itself needs ts_ls
local lspconfig_servers = {}
for _, server in pairs(servers) do
    if server == "ts_ls" then
        table.insert(lspconfig_servers, "tsserver");
    else
        table.insert(lspconfig_servers, server);
    end
end

local settings = {
    ui = {
        border = "none",
        icons = {
            package_installed = "◍",
            package_pending = "◍",
            package_uninstalled = "◍",
        },
    },
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
}

require("mason").setup(settings)
require("mason-lspconfig").setup({
    ensure_installed = lspconfig_servers,
    automatic_installation = true,
})

local is_ok, lspconfig = pcall(require, "lspconfig")
if not is_ok then
    vim.notify("failed to find lspconfig")
    return
end

local is_ok, handlers = pcall(require, "dzu.lsp.handlers")
if not is_ok then
    vim.notify("failed to initialize LSP handlers")
    return
end

local opts = {}

for _, server in pairs(servers) do
    opts = {
        on_attach = handlers.on_attach,
        capabilities = handlers.capabilities,
    }

    server = vim.split(server, "@")[1]

    local is_ok, conf_opts = pcall(require, "dzu.lsp." .. server)
    if is_ok then
        opts = vim.tbl_deep_extend("force", conf_opts, opts)
    else
        vim.notify("Failed to initialize config for " .. server)
    end

    lspconfig[server].setup(opts)
end
