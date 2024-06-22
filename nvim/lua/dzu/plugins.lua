local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

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
        lazy = true, -- *yeah, lazy-load everything!*
        version = nil,
        -- default `cond` you can use to globally disable a lot of plugins
        -- when running inside vscode for example
        cond = nil, ---@type boolean|fun(self:LazyPlugin):boolean|nil
        -- version = "*", -- enable this to try installing the latest stable versions of plugins
      },
      -- leave nil when passing the spec as the first argument to setup()
      spec = nil, ---@type LazySpec
      local_spec = true, -- load project specific .lazy.lua spec files. They will be added at the end of the spec.
      lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json", -- lockfile generated after running update.
      ---@type number? limit the maximum amount of concurrent tasks
      concurrency = jit.os:find("Windows") and (vim.uv.available_parallelism() * 2) or nil,
      git = {
        -- defaults for the `Lazy log` command
        -- log = { "--since=3 days ago" }, -- show commits from the last 3 days
        log = { "-8" }, -- show the last 8 commits
        timeout = 120, -- kill processes that take more than 2 minutes
        url_format = "https://github.com/%s.git",
        -- lazy.nvim requires git >=2.19.0. If you really want to use lazy with an older version,
        -- then set the below to false. This should work, but is NOT supported and will
        -- increase downloads a lot.
        filter = true,
      },
      dev = {
        ---@type string | fun(plugin: LazyPlugin): string directory where you store your local plugin projects
        -- path = "~/projects", -- TODO: add my path here
        ---@type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
        patterns = {}, -- For example {"folke"}
        fallback = false, -- Fallback to git when local plugin doesn't exist
      },
      install = {
        -- install missing plugins on startup. This doesn't increase startup time.
        missing = true,
        -- try to load one of these colorschemes when starting an installation during startup
        -- colorscheme = { "habamax" }, -- idk, just don't
      },
      ui = {
        -- a number <1 is a percentage., >1 is a fixed size
        size = { width = 0.9, height = 0.8 },
        wrap = true, -- wrap the lines in the ui
        -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
        border = "rounded",
        -- The backdrop opacity. 0 is fully opaque, 100 is fully transparent.
        backdrop = 90,
        title = nil, ---@type string only works when border is not "none"
        title_pos = "center", ---@type "center" | "left" | "right"
        -- Show pills on top of the Lazy window
        pills = true, ---@type boolean
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
    
          ["<localleader>l"] = {
            function(plugin)
              require("lazy.util").float_term({ "lazygit", "log" }, {
                cwd = plugin.dir,
              })
            end,
            desc = "Open lazygit log",
          },
    
          ["<localleader>t"] = {
            function(plugin)
              require("lazy.util").float_term(nil, {
                cwd = plugin.dir,
              })
            end,
            desc = "Open terminal in plugin dir",
          },
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
        concurrency = 1, ---@type number? set to 1 to check for updates very slowly
        notify = true, -- get a notification when new updates are found
        frequency = 3600, -- check for updates every hour
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
          reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory
          ---@type string[]
          paths = {}, -- add any custom paths here that you want to includes in the rtp
          ---@type string[] list any plugins you want to disable here
          disabled_plugins = {
            -- "gzip",
            -- "matchit",
            -- "matchparen",
            -- "netrwPlugin",
            -- "tarPlugin",
            -- "tohtml",
            -- "tutor",
            -- "zipPlugin",
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

local plugins = {
    -- colorscheme
    { "bluz71/vim-moonfly-colors", name = "moonfly", lazy = false, priority = 1000 },

    -- statusline at the bottom
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    },

    -- diffview
    "sindrets/diffview.nvim",

    -- file explorer
    "nvim-tree/nvim-tree.lua",
    --[[
    {
        'stevearc/oil.nvim',
        opts = {},
        -- Optional dependencies
        dependencies = { "nvim-tree/nvim-web-devicons" },
    }
    ]]--

    -- tree sitter
    "nvim-treesitter/nvim-treesitter",

    -- completions
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "saadparwaiz1/cmp_luasnip",
            "L3MON4D3/LuaSnip",
            "f3fora/cmp-spell",
            -- "amarakon/nvim-cmp-lua-latex-symbols" -- unfortunately, these are not latex
            -- completions, but rather unicode symbol inserter
        }
    },

    -- snippets
    {
	    "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*",
        build = "make install_jsregexp",
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
    },

    -- markdown rendering
    {
        'MeanderingProgrammer/markdown.nvim',
        name = 'render-markdown', -- Only needed if you have another plugin named markdown.nvim
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
    },


    -- floating temrinal
    {
        "voldikss/vim-floaterm",
        lazy = false
    },
}

-- manage plugins
lazy.setup(plugins, config)

-- bottom statusline
require 'dzu.plugins.lualine'

-- file diff
require 'dzu.plugins.diffview'

-- file explorer
require 'dzu.plugins.nvim-tree'
-- require 'dzu.plugins.oil'

-- tree sitter
require 'dzu.plugins.tree-sitter'

-- cmp
require 'dzu.cmp'

-- markdown rendering
require 'dzu.plugins.markdown'

-- Autocommand that reloads neovim whenever you save the plugins.lua file
-- vim.cmd [[
--   augroup lazy_nvim_user_config
--    autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | Lazy sync
--   augroup end
-- ]]
-- (good autocommand example anyway, so I'll keep it)
