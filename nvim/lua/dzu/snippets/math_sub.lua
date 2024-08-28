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
local fmt = require("luasnip.extras.fmt").fmt
local treesitter_postfix = require("luasnip.extras.treesitter_postfix").treesitter_postfix

local mathzone = function(_, _, _) return in_mathzone() end;

return {
    ft = "markdown",
    s({
        trig = [[(?:([a-zA-Z])|\(([^\(\)]+)\))(\d)]],
        condition = mathzone,
        snippetType = "autosnippet",
        wordTrig = false,
        trigEngine = "ecma",
    }, {
        f(function(_, parent, _)
            local caps = parent.captures
            local expr = caps[1]
            if expr == "" then
                expr = '{' .. caps[2] .. '}'
            end
            local digit = caps[3]
            return expr .. '_' .. digit
        end, {}, {})
    }, {}),
    s({
        trig = [[(?:([a-zA-Z])|{([^\(\)]+)})_(\d\d)]],
        condition = mathzone,
        snippetType = "autosnippet",
        wordTrig = false,
        trigEngine = "ecma",
    }, {
        f(function(_, parent, _)
            local caps = parent.captures
            local expr = caps[1]
            if expr == "" then
                expr = '{' .. caps[2] .. '}'
            end
            local digits = caps[3]
            return expr .. '_{' .. digits
        end, {}, {}),
        i(1),
        t('}'),
    }, {}),
    s({
        trig = [[(?:([a-zA-Z])|\(([^\(\)]+)\))sts]],
        condition = mathzone,
        snippetType = "autosnippet",
        wordTrig = false,
        trigEngine = "ecma",
    }, {
        f(function(_, parent, _)
            local caps = parent.captures
            local expr = caps[1]
            return '{' .. expr .. '}_{\\text{'
        end, {}, {}), i(1), t("}}")
    }, {}),
    s({
        trig = "_",
        condition = mathzone,
        snippetType = "autosnippet",
        wordTrig = false,
    }, {
        t("_{"), i(1), t("}")
    }, {})
}
