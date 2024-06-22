function config()
    local colorscheme = "moonfly"
    vim.g.moonflyItalics = false -- I don't like comments being italic, srry
    vim.g.moonflyNormalFloat = true -- style floating windows with moonfly too!
    -- vim.g.moonflyUnderlineMatchParen = true -- emph matching parens

    local is_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
    if not is_ok then
        vim.notify("colorscheme " .. colorscheme .. " not found!")
        return
    end
end

return {
    "bluz71/vim-moonfly-colors",
    name = "moonfly",
    priority = 1000,
    config = config,
    lazy = false,
}
