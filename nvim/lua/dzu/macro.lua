local M = {}

-- add toggle for white space helpers
local whitespace_helpers = true
function M.toggle_whitespace_helpers()
    if whitespace_helpers then
        whitespace_helpers = false
        vim.opt.list = false
        listchars = 'eol:,multispace:,trail:' -- add binding to toggle these
    else
        whitespace_helpers = true
        vim.opt.list = true
        listchars = 'eol:↩,multispace:   |,trail:-' -- add binding to toggle these
    end
end

-- limiting line must be disable in readonly windows
vim.api.nvim_create_autocmd("BufEnter", {
    callback = function(event_data)
        if vim.bo[event_data.buf].readonly then
            vim.opt.colorcolumn = ''
        end
    end
})


-- CRED: https://github.com/nvim-treesitter/nvim-treesitter/issues/1184#issuecomment-1079844699
local has_treesitter, ts = pcall(require, 'vim.treesitter')
local _, query = pcall(require, 'vim.treesitter.query')

local MATH_NODES = {
    displayed_equation = true,
    inline_formula = true,
    math_environment = true,
}

local COMMENT = {
    ['comment'] = true,
    ['line_comment'] = true,
    ['block_comment'] = true,
    ['comment_environment'] = true,
}

local function get_node_at_cursor()
    local buf = vim.api.nvim_get_current_buf()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    row = row - 1
    col = col - 1

    local ok, parser = pcall(ts.get_parser, buf, 'latex')
    if not ok or not parser then return end

    local root_tree = parser:parse()[1]
    local root = root_tree and root_tree:root()

    if not root then
        return
    end

    return root:named_descendant_for_range(row, col, row, col)
end

function M.in_comment()
    if has_treesitter then
        local node = get_node_at_cursor()
        while node do
            if COMMENT[node:type()] then
                return true
            end
            node = node:parent()
        end
        return false
    end
end

function M.in_mathzone()
    if has_treesitter then
        local node = get_node_at_cursor()
        while node do
            if node:type() == 'text_mode' then
                return false
            elseif MATH_NODES[node:type()] then
                return true
            end
            node = node:parent()
        end
        return false
    end
end

function M.suffix_paren_content(line)
    local i = string.len(line)
    if string.sub(line, i, i) ~= ')' then
        return ""
    end
    i = i - 1
    local depth = 1
    while i >= 1 and depth > 0 do
        if string.sub(line, i, i) == ')' then
            depth = depth + 1
        elseif string.sub(line, i, i) == '(' then
            depth = depth - 1
        end
        i = i - 1
    end
    if depth ~= 0 then
        return ""
    end
    return string.sub(line, i + 2, -2)
end

local NON_WORD = { '{', '}', ')', '(', ' ', '\t' }
function M.last_word(line)
    local i = string.len(line)
    while i > 0 do
        local c = string.sub(line, i, i)
        for _, val in pairs(NON_WORD) do
            if val == c then
                goto outer
            end
        end
        i = i - 1
    end
    ::outer::
    return string.sub(line, i + 1, -1)
end

-- CRED: https://ejmastnak.com/tutorials/vim-latex/luasnip/#advanced-nodes
--
-- This is the `get_visual` function I've been talking about.
-- ----------------------------------------------------------------------------
-- Summary: When `LS_SELECT_RAW` is populated with a visual selection, the function
-- returns an insert node whose initial text is set to the visual selection.
-- When `LS_SELECT_RAW` is empty, the function simply returns an empty insert node.
function M.get_visual(snippet)
    return snippet.env.LS_SELECT_RAW
end

return M
