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


return {
    ft = "markdown",
    s({
        trig = "qq",
        condition = mathzone,
        snippetType = "autosnippet",
        trigEngine = "ecma",
    }, t("\\qquad "), {})
}
