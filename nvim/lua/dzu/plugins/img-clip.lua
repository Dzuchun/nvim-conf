return {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    opts = {
        default = {
            -- file and directory options
            dir_path = "/home/dzu/.wiki/attachments/", ---@type string
            extension = "png", ---@type string
            file_name = "%Y-%m-%d-%H-%M-%S", ---@type string
            use_absolute_path = false, ---@type boolean
            relative_to_current_file = false, ---@type boolean
        }
    },
    lazy = false,
}
