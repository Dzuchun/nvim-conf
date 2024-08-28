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

local mathzone = function(_, _, _) return in_mathzone() end;


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
    replace("@e", "\\epsilon"),
    replace("@r", "\\rho"),
    replace("@t", "\\theta"),
    replace("@o", "\\omega"),
    replace("@p", "\\pi"),
    replace("@a", "\\alpha"),
    replace("@s", "\\sigma"),
    replace("@d", "\\delta"),
    replace("@f", "\\phi"),
    replace("@g", "\\gamma"),
    replace("@k", "\\kappa"),
    replace("@l", "\\lambda"),
    replace("@z", "\\zeta"),
    replace("@x", "\\chi"),
    replace("@b", "\\beta"),
    replace("@n", "\\nu"),
    replace("@m", "\\mu"),
    replace(":t", "\\tau"),
    replace(":e", "\\varepsilon"),
    replace(":f", "\\varphi"),
    replace("@E", "\\Epsilon"),
    replace("@R", "\\Rho"),
    replace("@T", "\\Theta"),
    replace("@O", "\\Omega"),
    replace("@P", "\\Pi"),
    replace("@A", "\\Alpha"),
    replace("@S", "\\Sigma"),
    replace("@D", "\\Delta"),
    replace("@F", "\\Phi"),
    replace("@G", "\\Gamma"),
    replace("@K", "\\Kappa"),
    replace("@L", "\\Lambda"),
    replace("@Z", "\\Zeta"),
    replace("@X", "\\Chi"),
    replace("@B", "\\Beta"),
    replace("@N", "\\Nu"),
    replace("@M", "\\Mu"),
}
