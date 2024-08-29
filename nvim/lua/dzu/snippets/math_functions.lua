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

local function func_snip(func_name, priority)
    if priority == nil then
        priority = 10
    end
    return s({
        trig = func_name,
        condition = mathzone,
        snippetType = "autosnippet",
        priority = priority,
    }, fmt([[\text{{{}}}\left({}\right)]], { t(func_name), i(1) }), {})
end

local function func_snip_add(func_name, add)
    return s({
        trig = "\\text{" .. func_name .. "}\\left(" .. add .. add,
        condition = mathzone,
        snippetType = "autosnippet",
    }, fmt([[\text{{{}}}\left({}]], { t(func_name .. add), i(1) }), {})
end

return {
    ft = "markdown",
    func_snip("sin"),
    func_snip("cos"),
    func_snip("tan"),
    func_snip("cot"),
    func_snip("exp"),
    func_snip("sec"),
    func_snip("csc"),
    func_snip("arcsin", 20),
    func_snip("arccos", 20),
    func_snip("arctan", 20),
    func_snip("arccot", 20),
    func_snip_add("sin", "c"),
    func_snip_add("sin", "h"),
    func_snip_add("cos", "h"),
    func_snip_add("tan", "h"),
    func_snip_add("cot", "h"),
}
