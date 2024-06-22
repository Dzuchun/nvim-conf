local colorscheme = "moonfly"

vim.g.moonflyItalics = false -- I don't line comments being italic, srry
vim.g.moonflyNormalFloat = true -- style floating windows with moonfly too!
-- vim.g.moonflyUnderlineMatchParen = true -- emph matching parens

local is_ok, _schema = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not is_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

