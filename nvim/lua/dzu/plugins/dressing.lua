local function config()
    local is_ok, dressing = pcall(require, 'dressing')
    if not is_ok then
        vim.notify("failed to load dressing.nvim (input floating windows)")
        return
    end

    local opts = {

        input = {
            -- Set to false to disable the vim.ui.input implementation
            enabled = true,

            -- Default prompt string
            default_prompt = "Input",

            -- Trim trailing `:` from prompt
            trim_prompt = true,

            -- Can be 'left', 'right', or 'center'
            title_pos = "left",

            -- The initial mode when the window opens (insert|normal|visual|select).
            start_mode = "insert",

            -- These are passed to nvim_open_win
            border = "rounded",
            -- 'editor' and 'win' will default to being centered
            relative = "cursor",

            -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
            prefer_width = 40,
            width = nil,
            -- min_width and max_width can be a list of mixed types.
            -- min_width = {20, 0.2} means "the greater of 20 columns or 20% of total"
            max_width = { 140, 0.9 },
            min_width = { 20, 0.2 },

            buf_options = {},
            win_options = {
                -- Disable line wrapping
                wrap = false,
                -- Indicator for when text exceeds window
                list = true,
                listchars = "precedes:…,extends:…",
                -- Increase this for more context when text scrolls off the window
                sidescrolloff = 0,
            }
        }
    }

    dressing.setup(opts)
end

return {
    'stevearc/dressing.nvim',
    config = config,
    lazy = false,
}
