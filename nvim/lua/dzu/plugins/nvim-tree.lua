-- CRED: nvim-tree setup
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

is_ok, nvim_tree = pcall(require, 'nvim-tree')
if not is_ok then
    vim.notify("couldn't find nvim-tree (file browser)")
    return
end

local config = {
    sort = {
      sorter = "case_sensitive",
    },
    view = {
      width = 30,
    },
    renderer = {
      group_empty = true,
    },
    filters = {
      dotfiles = true,
    },
  }

nvim_tree.setup(config)
