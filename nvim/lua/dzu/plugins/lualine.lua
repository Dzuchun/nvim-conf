local function config()
    -- CRED: lualine help
    local opts = {
        options = {
            icons_enabled = true,
            theme = 'moonfly',
            component_separators = { left = '', right = '' },
            section_separators = { left = '', right = '' },
            disabled_filetypes = {
                statusline = {},
                winbar = {},
            },
            ignore_focus = {},
            always_divide_middle = true,
            globalstatus = false,
            refresh = {
                statusline = 1000,
                tabline = 1000,
                winbar = 1000,
            }
        },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = {
                'branch',
                {
                    'diff',
                    colored = true, -- Displays a colored diff status if set to true
                    diff_color = {
                        -- Same color values as the general color option can be used here.
                        added    = { fg = '#70FF70' },                        -- Changes the diff's added color
                        modified = { fg = '#D0D070' },                        -- Changes the diff's modified color
                        removed  = { fg = '#FF7070' },                        -- Changes the diff's removed color you
                    },
                    symbols = { added = '+', modified = '~', removed = '-' }, -- Changes the symbols used by the diff.
                    source = nil,                                             -- TODO: add diff source
                    -- It must return a table as such:
                    --   { added = add_count, modified = modified_count, removed = removed_count }
                    -- or nil on failure. count <= 0 won't be displayed.
                },
                'diagnostics'
            },
            lualine_c = {},
            lualine_x = {
                { 'filename', file_status = true, newfile_status = true, path = 1 },
                'filetype',
            },
            lualine_y = { 'progress' },
            lualine_z = { 'location' }
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { 'filename' },
            lualine_x = { 'location' },
            lualine_y = {},
            lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
    }

    local is_ok, lualine = pcall(require, 'lualine')
    if not is_ok then
        vim.notify("couldn't locate a lualine (fancy bottom status line)")
        return
    end
    lualine.setup(opts)
end

return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = config,
    lazy = false,
}
