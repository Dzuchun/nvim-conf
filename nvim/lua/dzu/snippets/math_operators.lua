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


local function replace(from, to)
    return s({
            trig = from,
            name = "replace " .. from .. " with " .. to,
            snippetType = "autosnippet",
            condition = mathzone,
        },
        t(to), {});
end

return {
    ft = "markdown",
    s({
            trig = "sq",
            condition = mathzone,
            snippetType = "autosnippet",
        },
        fmt("\\sqrt{{{}}}", i(1))
        , {}),
    s({
            trig = "Re",
            condition = mathzone,
            snippetType = "autosnippet",
        },
        t("\\mathrm{Re} ")
        , {}),
    s({
            trig = "Im",
            condition = mathzone,
            snippetType = "autosnippet",
        },
        t("\\mathrm{Im} ")
        , {}),
    replace("del", " \\nabla "),
    replace("\\nabla ,.", "\\vec{\\nabla} "),
    replace("\\nabla .,", "\\vec{\\nabla} "),
    s({
            trig = "lim",
            condition = mathzone,
            snippetType = "autosnippet",
        },
        fmt([[\lim_{{ {} \to {} }} ]], { i(1, "n"), i(2, "\\infty") })
        , {}),
    replace("sum", "\\sum "),
    replace("prod", "\\prod "),
    s({
            trig = "lms",
            condition = mathzone,
            snippetType = "autosnippet",
        },
        fmt([[\limits_{{ {} }}^{{ {} }} ]], { i(1), i(2) }), {}),
    s({
            trig = "int",
            condition = mathzone,
            snippetType = "autosnippet",
        },
        fmt([[\int\limits_{{ {} }}^{{ {} }} {} \ d{} ]], { i(1), i(2), i(3), i(4, "x") })
        , {}),
    s({
            trig = "oinf",
            condition = mathzone,
            snippetType = "autosnippet",
        },
        fmt([[\int\limits_{{0}}^{{\infty}} {} \ d{} ]], { i(1), i(2, "x") })
        , {}),
    s({
            trig = "infi",
            condition = mathzone,
            snippetType = "autosnippet",
        },
        fmt([[\int\limits_{{-\infty}}^{{\infty}} {} \ d{} ]], { i(1), i(2, "x") })
        , {}),
    s({
            trig = "vint",
            condition = mathzone,
            snippetType = "autosnippet",
        },
        fmt([[\int\limits_{{\mathbb{{R}}^3}} {} \ d\vec{{ {} }} ]], { i(1), i(2, "r") })
        , {}),
    replace("oint", "\\oint "),
    replace("iint", "\\iint "),
    replace("iiint", "\\iiint "),
    s({
            trig = "rsd",
            condition = mathzone,
            snippetType = "autosnippet",
        },
        fmt([[\underset{{ {} = {} }}{{\text{{res}}}} ]], { i(1, "z"), i(2) })
        , {}),
}
