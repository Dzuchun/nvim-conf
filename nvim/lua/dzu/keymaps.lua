-- keymap optioins:
-- - forbid recursive mapping
-- - do not display auto-executed commands
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Leader keys
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
local nm = "n" -- normal mode
local im = "i" -- insert mode
local vm = "v" -- visual mode (selection?)
local vbm = "x" -- visual block
local tm = "t" -- terminal
local cm = "c" -- command (?)

-- Normal --
-- Window jumps with <Alt>+hjkl
keymap(nm, "<A-h>", "<C-w>h", opts)
keymap(nm, "<A-j>", "<C-w>j", opts)
keymap(nm, "<A-k>", "<C-w>k", opts)
keymap(nm, "<A-l>", "<C-w>l", opts)

-- Open explorer with 
-- keymap("n", "<leader>e", ":Lex 30<cr>", opts)

-- Window resize with <Alt>+'arrows'
keymap(nm, "<A-Up>", ":resize -2<CR>", opts)
keymap(nm, "<A-Down>", ":resize +2<CR>", opts)
keymap(nm, "<A-Left>", ":vertical resize -2<CR>", opts)
keymap(nm, "<A-Right>", ":vertical resize +2<CR>", opts)

-- Move along buffer stack with <Shift>+'arrows'
-- not sure what this is :(
-- keymap(nm, "<S-Right>", ":bnext<CR>", opts)
-- keymap(nm, "<S-Down>", ":bnext<CR>", opts)
-- keymap(nm, "<S-Left>", ":bprevious<CR>", opts)
-- keymap(nm, "<S-Up>", ":bprevious<CR>", opts)

-- Stop o and O from going into insert mode, that's not what I usually want
-- keymap(nm, "o", "o<BS><Right><Left><ESC>", opts)
-- keymap(nm, "O", "O<BS><Right><Left><ESC>", opts)

-- Visual --
-- Move selected text with <Alt>+hjkl
keymap(vm, "<A-h>", "<gv", opts)
keymap(vm, "<A-l>", ">gv", opts)
keymap(vm, "<A-j>", ":m .+1<CR>==", opts)
keymap(vm, "<A-k>", ":m .-2<CR>==", opts)

-- do not yank replaced visual
keymap(vm, "p", '"_dP', opts) 

-- toggle whitespace helpers
keymap(nm, "s", "<Nop>", opts)
keymap(nm, "sw", ":lua require('dzu.macro').toggle_whitespace_helpers()<CR>", opts)

keymap(nm, 'a', '<Nop>', opts) -- I don't actually use this one
keymap(nm, '<leader>a', ':NvimTreeToggle<CR>', opts) -- open file explorer in the current folder, shirnk it a bit, and move to the left-most

-- Visual Block --
-- Move text up and down
-- keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
-- keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
-- keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
-- keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Floaterm keymaps
keymap(nm, '<A-t>', '<ESC>:FloatermToggle myTerm<CR><C-l>', opts)
keymap(tm, '<ESC>', '<C-\\><C-n>:q<CR>', opts)
keymap(tm, '<A-p>', 'python<CR><C-l>', opts)
keymap(tm, '<A-l>', 'lua<CR><C-l>', opts)
keymap(tm, '<A-o>', 'octave<CR><C-l>', opts)
