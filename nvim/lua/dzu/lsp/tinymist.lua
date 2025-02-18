-- source: https://myriad-dreamin.github.io/tinymist//frontend/neovim.html
-- command to open current typst file in pdf
vim.api.nvim_create_user_command("OpenPdf", function()
    local filepath = vim.api.nvim_buf_get_name(0)
    if filepath:match("%.typ$") then
        -- os.execute("open " .. vim.fn.shellescape(filepath:gsub("%.typ$", ".pdf")))
        -- replace open with your preferred pdf viewer
        os.execute("zathura --fork " .. vim.fn.shellescape(filepath:gsub("%.typ$", ".pdf")))
    end
end, {})

return {
    settings = {
        formatterMode = "typstyle",
        exportPdf = "onType",
        semanticTokens = "disable"
    }
}
