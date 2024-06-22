local is_ok, configs = pcall(require, "nvim-treesitter.configs")
if not is_ok then
    vim.notify("couldn't find tree sitter config")
    return
end

configs.setup {
  ensure_installed = "all",
  sync_install = false, 
  ignore_install = { "" }, -- List of parsers to ignore installing
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "" }, -- list of language that will be disabled
    additional_vim_regex_highlighting = true,

  },
  indent = { enable = true, disable = {} },
}

-- latex parser
local is_ok, parsers = pcall(require, 'nvim-treesitter.parsers')
if not is_ok then
    vim.notify("couldn't find tree sitter parsers")
    return
end
local parser_configs = parsers.get_parser_configs()
parser_configs.latex = {
    install_info = {
        -- url = "~/Repositories/random/tree-sitter-latex/", -- local path or git repo
        url = "https://github.com/latex-lsp/tree-sitter-latex",
        files = {"src/parser.c", "src/scanner.c"}, -- note that some parsers also require src/scanner.c or src/scanner.cc
        -- optional entries:
        -- branch = "master", -- default branch in case of git repo if different from master
        generate_requires_npm = false, -- if stand-alone parser without npm dependencies
        requires_generate_from_grammar = true, -- if folder contains pre-generated src/parser.c
    },
    filetype = "tex", -- if filetype does not match the parser name
}

vim.cmd.TSUpdate()
