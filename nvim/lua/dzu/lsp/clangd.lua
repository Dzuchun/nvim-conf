return {
    filetypes = { "c", "h", "cpp" },
    single_file_support = true,
    cmd = {
        "clangd",
        -- "-Wall",
        "--enable-config",
    }
}
