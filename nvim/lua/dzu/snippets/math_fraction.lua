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
        trig = "//",
        condition = mathzone,
        snippetType = "autosnippet",
    }, {
        t("\\dfrac{"), i(1), t("}{"), i(2), t("}"),
    }, {}),
    s({
        trig = "[^\\s\\))]/",
        resolveExpandParams = function(_, line_to_cursor, _, _)
            local no_slash = string.sub(line_to_cursor, 0, -2)
            local numerator = last_word(no_slash)
            local trigger = string.sub(line_to_cursor, -1 - string.len(numerator), -1)
            return {
                trigger = trigger,
                captures = {
                    numerator = numerator
                },
            }
        end,
        snippetType = "autosnippet",
        condition = mathzone,
        wordTrig = false,
        trigEngine = "ecma",
    }, {

        f(function(_, parent, _)
            return '\\dfrac{' .. parent.captures.numerator .. '}{'
        end, {}, {}), i(1), t("}")
    }, {}),
    s({
        trig = [[\)/]],
        condition = mathzone,
        resolveExpandParams = function(_, line_to_cursor, _, _)
            local no_slash = string.sub(line_to_cursor, 0, -2)
            local numerator = paren_content(no_slash)
            local trigger = string.sub(line_to_cursor, -3 - string.len(numerator), -1)
            return {
                trigger = trigger,
                captures = {
                    numerator = numerator
                },
            }
        end,
        snippetType = "autosnippet",
        wordTrig = false,
        trigEngine = "ecma",
    }, {

        f(function(_, parent, _)
            return '\\dfrac{' .. parent.captures.numerator .. '}{'
        end, {}, {}), i(1), t("}")
    }, {}),
    s({
            trig = "/",
            condition = mathzone,
            wordTrig = false,
            snippetType = "autosnippet",
        },
        d(1, function(_, parent)
            local visual = get_visual(parent.snippet)
            if visual == nil or #visual == 0 then
                return sn(nil, t("/"))
            else
                return sn(nil, fmt("\\dfrac{{{}}}{{{}}}",
                    {
                        t(visual),
                        i(1),
                    }
                ))
            end
        end), {}),
}
