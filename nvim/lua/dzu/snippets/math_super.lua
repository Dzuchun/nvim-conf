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

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local mathzone = function(_, _, _) return in_mathzone() end;

local function replace_after_word(from, to)
    return s({
        trig = "\\w" .. from,
        condition = mathzone,
        snippetType = "autosnippet",
        wordTrig = false,
        trigEngine = "ecma",
        resolveExpandParams = function(_, _, matched_trigger, _)
            return { trigger = string.sub(matched_trigger, -string.len(from), -1) }
        end,
    }, t(to), {})
end

return {
    ft = "markdown",
    replace_after_word("sr", "^2"),
    replace_after_word("cb", "^3"),
    replace_after_word("inv", "^{-1}"),
    s({
        trig = "rd",
        condition = mathzone,
        snippetType = "autosnippet",
        wordTrig = false,
    }, { t("^{"), i(1), t("}") }, {}),
    s({
        trig = "ee",
        condition = mathzone,
        snippetType = "autosnippet",
    }, { t("e^{"), i(1), t("}"), }, {})
}
