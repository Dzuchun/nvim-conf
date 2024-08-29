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
    s({
        trig = "te",
        condition = mathzone,
        priotiry = 100,
    }, {
        t("\\text{ "), i(1), t(" }")
    }, {}),
    s({
        trig = "text",
        condition = mathzone,
        snippetType = "autosnippet",
        wordTrig = false,
    }, {
        t("\\text{ "), i(1), t(" }")
    }, {})
}
