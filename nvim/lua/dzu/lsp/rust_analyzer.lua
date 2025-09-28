return {
    settings = {
        ['rust-analyzer'] = {
            diagnostics = {
                enable = true,
                experimental = {
                    enable = true, -- sure hope these are marked somehow
                },
                styleLints = {
                    enable = true,
                },
            },
            cargo = {
                -- allTargets = false,
                allFeatures = false,
            },
            completion = {
                fullFunctionSignatures = {
                    enable = true -- show me bounds(?)
                },
                termSearch = {
                    enable = true, -- nested completions?
                },
            },
            hover = {
                actions = {
                    references = {
                        enable = true
                    },
                    run = {
                        enable = false, -- I run stuff with `cargo r`
                    }
                },
                memoryLayout = {
                    -- niches = true -- idk what's that, let's check!
                    -- UPD: wtf was that? :D
                },
                show = {
                    traitAssocItems = 5 -- Why would LSP not show me associated types?
                },
            },
            imports = {
                merge = {
                    glob = false -- I want to avoid ::* things
                }
            },
            inlayHints = {
                closureCaptureHints = {
                    enable = true
                },
                closureReturnTypeHints = {
                    enable = true
                },
                implicitDrops = {
                    enable = true, -- wow! this one might be A-MAZING for the newcomers!
                },
            },
            lens = {
                enable = false -- I'm in nvim, so it's a no, I guess
            },
            rustfmt = {
                extraArgs = {}, -- additional args to rustfmt
            },
            typing = {
                autoClosingAngleBrackets = {
                    enable = true -- let's try that :idk:
                }
            },
            checkOnSave = {
                allFeatures = false,
                command = "clippy",
                extraArgs = {
                    '--',
                    '-W', 'clippy::all',
                    '-W', 'clippy::pedantic',
                    '-A', 'clippy::used-underscore-binding',
                    -- '-A', 'clippy::doc_markdown',
                    '-A', 'clippy::needless_pass_by_value',
                    '-A', 'clippy::must_use_candidate',
                    '-A', 'clippy::return_self_not_must_use',
                    '-A', 'clippy::missing_errors_doc',
                    -- '-A', 'clippy::single_match',
                    '-A', 'clippy::uninlined_format_args',
                    '-A', 'clippy::module_name_repetitions',
                }
            },
            procMacro = {
                ignored = {
                    leptos_macro = {
                        -- "component",
                        "server",
                    },
                },
            },
        }
    }
}
