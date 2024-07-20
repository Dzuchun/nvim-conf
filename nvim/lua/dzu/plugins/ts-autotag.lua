local opts = {
  opts = {
    -- Defaults
    enable_close = true, -- Auto close tags
    enable_rename = true, -- Auto rename pairs of tags
    enable_close_on_slash = false -- Auto close on trailing </
  },
  -- Also override individual filetype configs, these take priority.
  -- Empty by default, useful if one of the "opts" global settings
  -- doesn't work well in a specific filetype
  --[[
  per_filetype = {
    ["html"] = {
      enable_close = false
    }
  }
  ]]--
}

function config()
    local is_ok, autotag = pcall(require, 'nvim-ts-autotag')
    if not is_ok then
        vim.notify("Failed to find ts autotag (tag autoclosing)")
        return
    end
    autotag.setup(opts)
end

return {
    "windwp/nvim-ts-autotag",
    config = config,
    lazy=false,
}
