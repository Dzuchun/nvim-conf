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
            },
            completion = {
                fullFunctionSignatures = {
                    enable = true -- show me bounds(?)
                },
                snippets = {
                    custom = {
                         -- custom completion snippets here!
                    }
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
        }
    }
}
