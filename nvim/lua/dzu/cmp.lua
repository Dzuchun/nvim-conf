
local is_ok, cmp = pcall(require, "cmp")
if not is_ok then
    vim.notify "Couldn't load cmp (base)"
    return
end

local is_ok, luasnip = pcall(require, "luasnip")
if not is_ok then
    vim.notify "Couldn't load cmp (luasnip)"
    return
end

require("luasnip/loaders/from_vscode").lazy_load()

local check_backspace = function()
    local col = vim.fn.col "." - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

--   פּ ﯟ   some other good icons
local kind_icons = {
    Text = "",
    Method = "m",
    Function = "",
    Constructor = "",
    Field = "",
    Variable = "",
    Class = "",
    Interface = "",
    Module = "",
    Property = "",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = "",
}
-- find more here: https://www.nerdfonts.com/cheat-sheet

local is_ok, cmp_config_context = pcall(require, 'cmp.config.context')
if not is_ok then
    vim.notify("cmp config context was not found!")
    return
end
local spell_options = {
    keep_all_entries = false,
    enable_in_context = function()
        return cmp_config_context.in_treesitter_capture('spell')
    end,
    preselect_correct_word = false,
}

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users. -- yep, I'm the one
        end,
    },
    mapping = {
        -- CTRL-jk for item selection
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),

        -- CTRL-bf for scrolling docs
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),

        -- CTRL-SPACE to complete (?)
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),

        ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ["<C-e>"] = cmp.mapping {
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        },
        -- Accept currently selected item. If none selected, `select` first item.
        -- Set `select` to `false` to only confirm explicitly selected items.
        -- RETURN to select item. use only explicitly selected ones
        ["<CR>"] = cmp.mapping.confirm { select = false },

        -- UBERTAB setup or th
        ["<Tab>"] = cmp.mapping(
            function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expandable() then
                    luasnip.expand()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                elseif check_backspace() then
                    fallback()
                else
                    fallback()
                end
            end, {
                "i", -- use only in isert & select mode (?)
                "s",
            }
        ),
        -- USERTAB back setup or th
        ["<S-Tab>"] = cmp.mapping(
            function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, {
                "i",
                "s",
            }
        ),
    },
    formatting = {
        fields = {
            "kind", -- icon
            "abbr", -- source (&)
            "menu"
        },
        format = function(entry, vim_item)
            -- Kind icons
            -- vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
            vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
            -- names of sources
            vim_item.menu = ({
                -- nvim_lsp = "[LSP]", -- TODO: no LSP, for now
                luasnip = "[snip]",
                -- buffer = "[Buffer]", -- TODO: no buffer, for now
                -- path = "[Path]", -- TODO: no path, for now
                spell = "[spell]",
            })[entry.source.name]
            return vim_item
        end,
    },
    sources = {
        -- { name = "nvim_lsp" }, -- TODO: no lsp (for now)
        { name = "luasnip" },
        -- { name = "buffer" }, -- TODO: no buffer (for now)
        -- { name = "path" }, -- TODO: no path (for now)
        {
            name = "spell",
            option = spell_options,
        },
    },
    -- (?)
    confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
    },
    -- this field if deprecated
    --[[ documentation = {
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    },
    ]]--
    experimental = {
        ghost_text = false, -- EDIT: I DON'T WANNA GHOST TEXT, IT CONFUSES SO MUCH OMG
        native_menu = false,
    },
}

-- (la)tex specific snippets
cmp.setup.filetype({ "tex", "plaintex" }, {
    sources = {
        { name = "luasnip" },
        -- { name = "lua-latex-symbols", option = { cache = true } },
        { name = "spell", option = spell_options },
    }
})
