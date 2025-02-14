local function config()
    local is_ok, mason_nvim_lint = pcall(require, "mason-nvim-lint");
    if not is_ok then
        vim.notity("Failed to setup mason-lint");
        return;
    end

    local opts = {
        ensure_installed = {
            "black",    -- python formatter
            "biome",    -- web formater
            "fourmolu", -- haskell formatter
            "nixfmt",   -- nix formatter
            "clang_format",
        },
    }

    mason_nvim_lint.setup(opts);
end

return {
    "rshkarin/mason-nvim-lint",
    dependencies = {
        "williamboman/mason.nvim",
        "mfussenegger/nvim-lint",
    },
    config = config,
}
