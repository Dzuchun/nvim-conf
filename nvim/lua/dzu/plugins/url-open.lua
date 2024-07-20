local function config()
    local status_ok, url_open = pcall(require, "url-open")
    if not status_ok then
        return
    end
    url_open.setup({
        open_app = 'firefox',
    })
end

return {
    "sontungexpt/url-open",
    event = "VeryLazy",
    cmd = "URLOpenUnderCursor",
    config = config,
    lazy = false,
}
