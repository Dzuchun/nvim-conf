local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- TODO: figure out why lua_ls won't see this function
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local is_ok, lazy = pcall(require, 'lazy')
if not is_ok then
    vim.notify('Failed to find lazy.nvim', vim.log.levels.WARN)
    return
end

-- CRED: lazy.nvim config page
local config = {
    root = vim.fn.stdpath("data") .. "/lazy", -- directory where plugins will be installed
    defaults = {
        lazy = true,                          -- *yeah, lazy-load everything!*; Future me: f*ck that guy!
        version = nil,
        cond = nil,
    },
    -- leave nil when passing the spec as the first argument to setup()
    spec = nil,
    local_spec = true,                                        -- load project specific .lazy.lua spec files. They will be added at the end of the spec.
    lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json", -- lockfile generated after running update.
    -- TODO: figure out why lua_ls won't see this function
    --- limit the maximum amount of concurrent tasks
    concurrency = jit.os:find("Windows") and (vim.uv.available_parallelism() * 2) or nil,
    git = {
        log = { "-8" }, -- show the last 8 commits
        timeout = 120,  -- kill processes that take more than 2 minutes
        url_format = "https://github.com/%s.git",
        filter = true,
    },
    dev = {
        --- directory where you store your local plugin projects
        -- path = "~/projects", -- TODO: add my path here
        -- plugins that match these patterns will use your local versions instead of being fetched from GitHub
        patterns = {},    -- For example {"folke"}
        fallback = false, -- Fallback to git when local plugin doesn't exist
    },
    install = {
        -- install missing plugins on startup. This doesn't increase startup time.
        missing = true,
        -- try to load one of these colorschemes when starting an installation during startup
        colorscheme = { "moonfly" },
    },
    ui = {
        -- a number <1 is a percentage., >1 is a fixed size
        size = { width = 0.9, height = 0.8 },
        wrap = true, -- wrap the lines in the ui
        -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
        border = "rounded",
        -- The backdrop opacity. 0 is fully opaque, 100 is fully transparent.
        backdrop = 90,
        title = nil, -- only works when border is not "none"
        title_pos = "center", ---@type "center" | "left" | "right"
        -- Show pills on top of the Lazy window
        pills = true,
        icons = {
            cmd = " ",
            config = "",
            event = " ",
            ft = " ",
            init = " ",
            import = " ",
            keys = " ",
            lazy = "󰒲 ",
            loaded = "●",
            not_loaded = "○",
            plugin = " ",
            runtime = " ",
            require = "󰢱 ",
            source = " ",
            start = " ",
            task = "✔ ",
            list = {
                "●",
                "➜",
                "★",
                "‒",
            },
        },
        -- leave nil, to automatically select a browser depending on your OS.
        -- If you want to use a specific browser, you can define it here
        browser = nil, ---@type string?
        throttle = 20, -- how frequently should the ui process render events
        custom_keys = {
            -- You can define custom key maps here. If present, the description will
            -- be shown in the help menu.
            -- To disable one of the defaults, set it to false.
            ["<localleader>l"] = false,
            ["<localleader>t"] = false,
        },
    },
    diff = {
        -- diff command <d> can be one of:
        -- * browser: opens the github compare view. Note that this is always mapped to <K> as well,
        --   so you can have a different command for diff <d>
        -- * git: will run git diff and open a buffer with filetype git
        -- * terminal_git: will open a pseudo terminal with git diff
        -- * diffview.nvim: will open Diffview to show the diff
        cmd = "diffview.nvim",
    },
    checker = {
        -- automatically check for plugin updates
        enabled = true,
        concurrency = 1,     --set to 1 to check for updates very slowly
        notify = true,       -- get a notification when new updates are found
        frequency = 3600,    -- check for updates every hour
        check_pinned = true, -- check for pinned packages that can't be updated
    },
    change_detection = {
        -- automatically check for config file changes and reload the ui
        enabled = true,
        notify = true, -- get a notification when changes are found
    },
    performance = {
        cache = {
            enabled = true,
        },
        reset_packpath = true, -- reset the package path to improve startup time
        rtp = {
            reset = true,      -- reset the runtime path to $VIMRUNTIME and your config directory
            ---@type string[]
            paths = {},        -- add any custom paths here that you want to includes in the rtp
            ---@type string[] list any plugins you want to disable here
            disabled_plugins = {
            },
        },
    },
    -- lazy can generate helptags from the headings in markdown readme files,
    -- so :help works even for plugins that don't have vim docs.
    -- when the readme opens with :help it will be correctly displayed as markdown
    readme = {
        enabled = true,
        root = vim.fn.stdpath("state") .. "/lazy/readme",
        files = { "README.md", "lua/**/README.md" },
        -- only generate markdown helptags for plugins that dont have docs
        skip_if_doc_exists = true,
    },
    state = vim.fn.stdpath("state") .. "/lazy/state.json", -- state info for checker and other things
    build = {
        -- Plugins can provide a `build.lua` file that will be executed when the plugin is installed
        -- or updated. When the plugin spec also has a `build` command, the plugin's `build.lua` not be
        -- executed. In this case, a warning message will be shown.
        warn_on_override = true,
    },
    -- Enable profiling of lazy.nvim. This will add some overhead,
    -- so only enable this when you are debugging lazy.nvim
    profiling = {
        -- Enables extra stats on the debug tab related to the loader cache.
        -- Additionally gathers stats about all package.loaders
        loader = false,
        -- Track each new require in the Lazy profiling tab
        require = false,
    },
}

-- CRED: ME SMART
-- request low-level filesystem
local is_ok, uv = pcall(require, 'luv')
if not is_ok then
    vim.notify("libuv was not found (a really bad thing, btw): " .. uv)
    return
end
-- open plugins dir
local is_ok, d = pcall(uv.fs_opendir, vim.fn.stdpath('config') .. '/lua/dzu/plugins/', nil, 999999)
if not is_ok then
    vim.notify("failed to open plugins dir: " .. d)
    return
end
if d == nil then
    vim.notify("couldn't find plugins dir")
    return
end

-- iterate over plugins dir
local is_ok, files = pcall(uv.fs_readdir, d)
if not is_ok then
    vim.notify("failed to iterate over files in plugins dir: " .. files)
    return
end

local plugins = {}
for _, f in pairs(files) do
    local name = f['name']
    if name == '.' or name == '..' then
        goto continue
    end
    if f['type'] ~= 'file' then
        vim.notify('non-plugin file in plugins directory: ' .. name)
        goto continue
    end
    if string.sub(name, -5) == '.lua_' then
        -- That's a temporary-disabled files, just ignore it
        goto continue
    end
    if string.sub(name, -4) ~= '.lua' then
        vim.notify('non-plugin file in plugins directory: ' .. name)
        goto continue
    end
    local module_name = 'dzu.plugins.' .. string.sub(name, 1, -5)

    local is_ok, mod = pcall(require, module_name)
    if not is_ok then
        vim.notify("Couldn't load plugin " .. name)
    end
    table.insert(plugins, mod)
    ::continue::
end


-- close plugins dir
local is_ok, _ = pcall(uv.fs_closedir, d)
if not is_ok then
    vim.notify("failed to close plugins dir")
    return
end

lazy.setup(plugins, config)
