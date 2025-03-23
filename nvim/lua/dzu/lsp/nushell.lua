return {
    cmd = { "nu", "--plugins", "[~/.cargo/bin/nu_plugin_polars]", "--lsp", },
    filetypes = { "nu" },
    root_dir = require("lspconfig.util").find_git_ancestor,
    single_file_support = true,
}
