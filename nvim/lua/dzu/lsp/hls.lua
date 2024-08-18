return {
    filetypes = {
        'haskell',
        'lhaskell',
        'cabal'
    },
    haskell = {
        plugin = {
            rename = {
                config = {
                    diff = true,
                }
            },
            ['ghcide-completions'] = {
                config = {
                    snippetsOn = false
                }
            },
        }
    }
    -- cmd = { "haskell-language-server-wrapper", "--lsp", "-Wall" }
    -- formattingProvider = "hls-stylish-haskell-plugin",
    -- CRED: https://github.com/haskell/haskell-language-server/issues/4363 -- does not
    -- work
    --[[
    settings = {
        plugin = {
            -- CRED: https://github.com/haskell/haskell-language-server/issues/680 --
            -- does not work too!
            ['ghcide'] = {
                completionOn = false,
            },
            ['pramas'] = {
                completionOn = false,
            },
            ['ghcide-completions'] = {
                config = {
                    snippetsOn = false,
                    autoExtendOn = true
                }
            }
        }
    }
    ]] --
}
