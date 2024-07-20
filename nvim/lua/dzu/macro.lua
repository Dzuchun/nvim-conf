-- add toggle for white space helpers
local whitespace_helpers = true
function toggle_whitespace_helpers()
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

toggle_whitespace_helpers()

-- limiting line must be disable in readonly windows
vim.api.nvim_create_autocmd("BufEnter", {
    callback = function(event_data)
        if vim.bo[event_data.buf].readonly then
            vim.opt.colorcolumn = ''
        end
    end
})

return {
    toggle_whitespace_helpers = toggle_whitespace_helpers
}
