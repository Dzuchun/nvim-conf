local servers = {
    "rust_analyzer", -- rust
    "pyright",       -- has no code formatting
    -- "marksman",      -- markdown
    "ts_ls",         -- js, ts, tsx
    "clangd",        -- C
    "lua_ls",
    "hls",
    "nil_ls",
    "tinymist",
    "dockerls",
    "html",
    -- "jdtls",
}
local nvimlsp_only_servers = {
    "nushell",
}

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
    ensure_installed = servers,
    automatic_enable = false,
    automatic_installation = true,
})

local is_ok, handlers = pcall(require, "dzu.lsp.handlers")
if not is_ok then
    vim.notify("failed to initialize LSP handlers")
    return
end
handlers.setup()

local opts = {}

local nvim_lsp_servers = {}
for _, nlsp_s in pairs(nvimlsp_only_servers) do
    table.insert(nvim_lsp_servers, nlsp_s)
end
for _, s in pairs(servers) do
    table.insert(nvim_lsp_servers, s)
end

for _, server in pairs(nvim_lsp_servers) do
    opts = {
        -- on_attach = handlers.on_attach,
        capabilities = handlers.capabilities,
    }

    server = vim.split(server, "@")[1]

    local is_ok, conf_opts = pcall(require, "dzu.lsp." .. server)
    if is_ok then
        opts = vim.tbl_deep_extend("force", conf_opts, opts)
    else
        vim.notify("Failed to initialize config for " .. server)
    end

    vim.lsp.config(server, opts)
    vim.lsp.enable(server, true)
end
