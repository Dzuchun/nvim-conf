local is_ok, macro = pcall(require, "dzu.macro")
if not is_ok then
    vim.notify "Failed to load macro-utils"
    return
end
local in_mathzone = macro.in_mathzone;

local is_ok, ls = pcall(require, "luasnip")
if not is_ok then
    vim.notify "Custom math snippets require luasnip"
    return
end


local t = ls.text_node
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local sn = ls.snippet_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local treesitter_postfix = require("luasnip.extras.treesitter_postfix").treesitter_postfix

local mathzone = function(_, _, _) return in_mathzone() end;
local paren_content = macro.suffix_paren_content;
local last_word = macro.last_word;
local get_visual = macro.get_visual

return {
    ft = "markdown",
    s({
            trig = "bar",
            condition = mathzone,
            snippetType = "autosnippet",
            priority = 10,
        },
        fmt("\\overline{{{}}}", i(1))
        , {}),
    s({
            trig = "([A-Za-z])bar",
            condition = mathzone,
            snippetType = "autosnippet",
            priority = 100,
            wordTrig = false,
            trigEngine = "ecma",
        },
        {
            f(function(_, parent, _)
                local caps = parent.captures
                local letter = caps[1]
                return "\\overline{" .. letter .. "}"
            end)
        }
        , {}),
    s({
            trig = "hat",
            condition = mathzone,
            snippetType = "autosnippet",
            priority = 10,
            wordTrig = false,
        },
        fmt("\\hat{{{}}}", i(1))
        , {}),
    s({
            trig = "([A-Za-z])hat",
            condition = mathzone,
            snippetType = "autosnippet",
            priority = 100,
            wordTrig = false,
            trigEngine = "ecma",
        },
        {
            f(function(_, parent, _)
                local caps = parent.captures
                local letter = caps[1]
                return "\\hat{" .. letter .. "}"
            end)
        }
        , {}),
    s({
            trig = "vec",
            condition = mathzone,
            snippetType = "autosnippet",
            priority = 10,
            trigEngine = "ecma",
        },
        fmt("\\vec{{{}}}", i(1))
        , {}),
    s({
            trig = "(\\\\?[A-Za-z]+)(?:(?:,\\.)|(?:\\.,)|vec)",
            condition = mathzone,
            snippetType = "autosnippet",
            priority = 100,
            wordTrig = false,
            trigEngine = "ecma",
        },
        {
            f(function(_, parent, _)
                local caps = parent.captures
                local inner = caps[1]
                return "\\vec{" .. inner .. "}"
            end)
        }
        , {}),
    s({
            trig = "dot",
            condition = mathzone,
            snippetType = "autosnippet",
            priority = 10,
        },
        fmt("\\dot{{{}}}", i(1))
        , {}),
    s({
            trig = "ddot",
            condition = mathzone,
            snippetType = "autosnippet",
            priority = 10,
        },
        fmt("\\ddot{{{}}}", i(1))
        , {}),
    s({
            trig = "und",
            condition = mathzone,
            snippetType = "autosnippet",
            priority = 10,
        },
        fmt("\\underline{{{}}}", i(1))
        , {}),
}
