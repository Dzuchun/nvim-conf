local function config()
    local is_ok, configs = pcall(require, "nvim-treesitter.configs")
    if not is_ok then
        vim.notify("couldn't find tree sitter config")
        return
    end

    local config_opts = {
        ensure_installed = {
            "bash",
            "c",
            "comment",
            "cpp",
            "csv",
            -- "cuda", -- not yet; might enable in the future
            "djot",
            "dockerfile", -- oh yeah. I should probably figure docker out...
            "fish",
            "gitignore",
            -- "git_commit",
            "haskell",
            "html",
            "javascript",
            "typescript",
            -- "jsx",
            "tsx",
            "json",
            "latex",
            "lua",
            "luadoc",
            "make",
            "markdown",
            "markdown_inline",
            "python",
            "rust",
            "sql",
            "toml",
            "vim",
            "vimdoc",
            "xml",
            "nu",
        },
        sync_install = false,
        ignore_install = { "" }, -- List of parsers to ignore installing
        highlight = {
            enable = true,       -- false will disable the whole extension
            disable = { "" },    -- list of language that will be disabled
            additional_vim_regex_highlighting = true,

        },
        indent = { enable = true, disable = {} },
    }
    configs.setup(config_opts)

    -- latex parser
    local is_ok, parsers = pcall(require, 'nvim-treesitter.parsers')
    if not is_ok then
        vim.notify("couldn't find tree sitter parsers")
        return
    end
    local parser_configs = parsers.get_parser_configs()
    parser_configs.latex = {
        install_info = {
            url = "https://github.com/latex-lsp/tree-sitter-latex",
            files = { "src/parser.c", "src/scanner.c" }, -- note that some parsers also require src/scanner.c or src/scanner.cc
            -- optional entries:
            -- branch = "master", -- default branch in case of git repo if different from master
            generate_requires_npm = false,         -- if stand-alone parser without npm dependencies
            requires_generate_from_grammar = true, -- if folder contains pre-generated src/parser.c
        },
        filetype = "tex",                          -- if filetype does not match the parser name
    }

    -- git commit parser
    parser_configs.git_commit = {
        install_info = {
            url = "~/Repositories/random/tree-sitter-git-commit/",
            files = { "src/parser.c" }, -- note that some parsers also require src/scanner.c or src/scanner.cc
            -- optional entries:
            -- branch = "master", -- default branch in case of git repo if different from master
            generate_requires_npm = false,          -- if stand-alone parser without npm dependencies
            requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
        },
        filetype = "gitcommit",                     -- if filetype does not match the parser name
    }

    vim.cmd.TSUpdate()
end

return {
    "nvim-treesitter/nvim-treesitter",
    config = config,
    lazy = false,
}
