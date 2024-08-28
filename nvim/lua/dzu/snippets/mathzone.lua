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
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local not_mathzone = function(_, _, _) return not in_mathzone() end;

return {
    ft = "markdown",
    s({
        trig = "mk",
        name = "inline mathmode",
        snippetType = "autosnippet",
        condition = not_mathzone,
    }, fmt("${}$", { i(1) }), {}),
    s({
            trig = "dm",
            name = "display mathmode",
            snippetType = "autosnippet",
            condition = not_mathzone,
        },
        fmt("\n$$\n{}\n$$\n"
        , { i(1) })
        , {}),
}
