-- keymap options:
-- - forbid recursive mapping
-- - do not display auto executed commands
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Leader keys
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
local nm = "n"  -- normal mode
local im = "i"  -- insert mode
local vm = "v"  -- visual mode
local vbm = "x" -- visual block
local tm = "t"  -- terminal
local cm = "c"  -- command (?)
local sm = "s"  -- selection mode

-- Normal --
-- Window jumps with <Alt>+hjkl
keymap(nm, "<A-h>", "<C-w>h", opts)
keymap(nm, "<A-j>", "<C-w>j", opts)
keymap(nm, "<A-k>", "<C-w>k", opts)
keymap(nm, "<A-l>", "<C-w>l", opts)

-- Window resize with <Alt>+'arrows'
keymap(nm, "<A-Up>", ":resize -2<CR>", opts)
keymap(nm, "<A-Down>", ":resize +2<CR>", opts)
keymap(nm, "<A-Left>", ":vertical resize -2<CR>", opts)
keymap(nm, "<A-Right>", ":vertical resize +2<CR>", opts)

-- Visual --
-- Move selected text with <Alt>+hjkl
keymap(vm, "<A-h>", "<gv", opts)
keymap(vm, "<A-l>", ">gv", opts)
-- TODO: these two do no work (but I would LOVE for them to)
-- keymap(vm, "<A-j>", ":m .+1<CR>==", opts)
-- keymap(vm, "<A-k>", ":m .-2<CR>==", opts)

-- do not yank replaced visual
keymap(vm, "p", '"_dP', opts)

-- toggle whitespace helpers
keymap(nm, "s", "<Nop>", opts)
keymap(nm, "sw", ":lua require('dzu.macro').toggle_whitespace_helpers()<CR>", opts)

-- open file browser
keymap(nm, '<leader>a', ':NvimTreeToggle<CR>', opts) -- open file explorer in the current folder, shirnk it a bit, and move to the left-most

-- Visual Block --
-- Move text up and down
-- keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
-- keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
-- keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
-- keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Floaterm keymaps
keymap(nm, '<A-t>', '<ESC>:FloatermToggle myTerm<CR>', opts)
keymap(tm, '<ESC>', '<C-\\><C-n>:q<CR>', opts)
keymap(tm, '<A-p>', 'ipython<CR><C-l>', opts)
keymap(tm, '<A-l>', 'lua<CR><C-l>', opts)
keymap(tm, '<A-o>', 'octave<CR><C-l>', opts)
keymap(tm, '<A-h>', 'ghci<CR><C-l>', opts)

-- insert image
keymap(nm, '<leader>p', '<ESC>:PasteImage<CR>', opts)

-- open link under cursor
keymap(nm, 'gx', '<ESC>:URLOpenUnderCursor<CR>', opts)

-- add Ukrainian kb layout support
vim.cmd(
    "set langmap=йq,цw,уe,кr,еt,нy,гu,шi,щo,зp,х[,ї],фa,іs,вd,аf,пg,рh,оj,лk,дl,ж\\\\;,\\є',ґ\\\\,яz,чx,сc,мv,иb,тn,ьm,б\\\\,,ю.,,ЙQ,ЦW,УE,КR,ЕT,НY,НY,ГU,ШI,ЩO,ЗP,Х{,Ї},ФA,\\ІS,ВD,АF,ПG,РH,ОJ,ЛK,ДL,Ж\\\\:,Є\\\\\",Ґ\\|,ЯZ,ЧX,СC,МV,ИB,ТN,ЬM,Б\\\\<,Ю>,№#")
-- add primitive commands for Ukrainian keyboard
vim.cmd("cnoreabbrev <expr> ц ((getcmdtype() is# ':' && getcmdline() is# 'ц')?('w'):('ц'))")
vim.cmd("cnoreabbrev <expr> й ((getcmdtype() is# ':' && getcmdline() is# 'й')?('q'):('й'))")
vim.cmd("cnoreabbrev <expr> цй ((getcmdtype() is# ':' && getcmdline() is# 'цй')?('wq'):('цй'))")

-- Stop o and O from going into insert mode, that's not what I usually want
keymap(nm, "o", "o<esc>", opts)
keymap(nm, "O", "O<esc>", opts)
keymap(nm, "щ", "o<esc>", opts)
keymap(nm, "Щ", "O<esc>", opts)

-- git diff view
keymap(nm, "<leader>\\", ":DiffviewOpen<CR>", opts)
keymap(nm, "<leader>|", ":DiffviewClose<CR>", opts)
keymap(nm, "<leader>g", ":diffget<CR>", opts)
keymap(nm, "<leader>p", ":diffput<CR>", opts)
keymap(nm, "<leader><C-g>", ":DiffviewRefresh<CR>", opts)
