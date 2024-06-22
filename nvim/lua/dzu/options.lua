vim.g.loaded_netrwPlugin = 1

-- cpoptions:
-- - s (default): copies options on creation
-- - S: copies options each time
local options = {
    belloff = { -- which bell signals are muted
        'backspace',
        'cursor',
        'complete',
        'copy',
        'ctrlg',
        'lang',
        'spell',
        'wildmode'
    },
    -- visualbell = true, -- FLASHES THE SCREEN
    -- binary - check out binary file viewing and editing
    breakat = " ^I!@*-+;:,./?", -- where line breaks are allowed
    -- breakindent = true, -- line breaks continue where the line starts
    breakindentopt = {
        'shift:0', -- indent by no char
        'sbr', -- show line break symbol
    },
    showbreak = '↪ ', -- line break symbol itself
    cdhome = false, -- do not cd to home on :cd (won't work?)
    cedit='', -- no kinding to open CL window (?)
    -- cmdheight = 7, -- number of lines for cmd
    colorcolumn = '+1,+2', -- highlight 2 columns after textwidth -- add autocmp to disable this in readonly buffers
    textwidth = 90, -- default number of chars per line
    concealcursor = 'nc', -- simplify text that's not being selected or modified
    conceallevel = 2, -- simplify more text (?)
    confirm = true, -- ask instead of failing
    expandtab = true, -- use spaces instead of tabs
    -- see cursor bind, diff
    cursorline = true, -- highlight the line cursor is on
    cursorlineopt = 'number', -- highlight line number where the cursor is
    debug = 'msg', -- tell me about problems, please
    -- see digraphs, to enable латинка!
    display = 'lastline,uhex', -- print unprintable chars in HEX (last line kinda won't work?)
    errorbells = true, -- sound on errors       
    exrc = true, -- execute possible local config
    fillchars = 'diff:<',
    foldlevelstart = 0, -- at start, close all folds...
    foldminlines = 50, -- but only fold really large things...
    foldmethod = 'indent', -- and identify them by indent
    -- look into lang* (langmenu)
    lazyredraw = true, -- might be a bad idea, IDK
    mouse = 'nvi', -- enable mouse at insert and visual
    mousehide = true, -- hide mouse when something is being typed
    -- mousefocus = true, -- focus on window where mouse is
    mousescroll = 'ver:2,hor:3',
    -- mouses = 'n:arrow,v:crosshair,i:beam', -- how mouse looks like in different modes
    number = true, -- print numbers at the start
    ruler = true, -- show row&column
    scrolloff = 3, -- minimal line count above and below the cursor
    shiftwidth = 4, -- tab size (4 is superior!)
    tabstop = 4, -- or is it this one...?
    splitright = true, -- splitting the window will put it to right
    list = true, -- show formatting chars
    listchars = 'eol:↩,multispace:   |,trail:-', -- add binding to toggle these

    -- spellcheck
    spell = true,
    spelllang = "en_us,uk",

    -- clipboard
    clipboard = 'unnamedplus',
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

