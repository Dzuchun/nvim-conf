-- CRED: ME SMART
local is_ok, ls = pcall(require, "luasnip")
if not is_ok then
    vim.notify "Snippets require luasnip"
    return
end

-- request low-level filesystem
local is_ok, uv = pcall(require, 'luv')
if not is_ok then
    vim.notify("libuv was not found (a really bad thing, btw): " .. uv)
    return
end
-- open snippets dir
local is_ok, d = pcall(uv.fs_opendir, vim.fn.stdpath('config') .. '/lua/dzu/snippets/', nil, 999999)
if not is_ok then
    vim.notify("failed to open snippets dir: " .. d)
    return
end
if d == nil then
    vim.notify("couldn't find snippets dir")
    return
end

-- iterate over snippets dir
local is_ok, files = pcall(uv.fs_readdir, d)
if not is_ok then
    vim.notify("failed to iterate over files in snippets dir: " .. files)
    return
end

for _, f in pairs(files) do
    local name = f['name']
    if name == '.' or name == '..' then
        goto continue
    end
    if f['type'] ~= 'file' then
        vim.notify('non-file file in plugins directory: ' .. name)
        goto continue
    end
    if string.sub(name, -5) == '.lua_' then
        -- That's a temporary-disabled files, just ignore it
        goto continue
    end
    if string.sub(name, -4) ~= '.lua' then
        vim.notify('non-plugin file in plugins directory: ' .. name)
        goto continue
    end
    local module_name = 'dzu.snippets.' .. string.sub(name, 1, -5)

    local is_ok, mod = pcall(require, module_name)
    if not is_ok then
        vim.notify("Couldn't load snippets " .. name)
    end
    local filetype = mod.ft
    if filetype == nil then
        vim.notify("Snippets file " .. name .. " does not provide a filetype");
        goto continue
    end
    for n, snip in pairs(mod) do
        if n ~= "ft" then
            ls.add_snippets(filetype, { snip });
        end
    end
    ::continue::
end


-- close snippets dir
local is_ok, _ = pcall(uv.fs_closedir, d)
if not is_ok then
    vim.notify("failed to close snippets dir")
    return
end
