
-- add toggle for whitespace helpers
local whitespace_helpers = true
function toggle_whitespace_helpers()
    if whitespace_helpers then
        whitespace_helpers = false
        vim.opt.list = false
        -- vim.opt.showbreak = ''
        listchars = 'eol:,multispace:,trail:' -- add binding to toggle these
        -- vim.notify('whitespace helpers hidden')
    else
        whitespace_helpers = true
        vim.opt.list = true
        -- vim.opt.showbreak = '↪'
        listchars = 'eol:↩,multispace:   |,trail:-' -- add binding to toggle these
        -- vim.notify('whitespace helpers shown')
    end
end
toggle_whitespace_helpers()

-- limiting line must be disable in readonly windows
vim.api.nvim_create_autocmd("BufEnter", {
    callback = function(event_data)
        -- local local_buffer = vim.api.nvim_win_get_buf(0)
        if vim.bo[event_data.buf].readonly then
            vim.opt.colorcolumn = ''
        end
    end
})

return {
   toggle_whitespace_helpers = toggle_whitespace_helpers
}
