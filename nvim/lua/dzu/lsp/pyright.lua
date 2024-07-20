return {
    settings = {
        pyright = {
            disableLanguageServices = false,
            disableOrganizeImports = false,
            disableTaggedHints = false,
        },
        python = {
            analysis = {
                autoImportCompletions = true,
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                diagnosticSeverityOverrides = {
                    reportAbstractUsage                 = "error",
                    reportArgumentType                  = "error",
                    reportAssertAlwaysTrue              = "warning",
                    reportAssertTypeFailure             = "error",
                    reportAssignmentType                = "error",
                    reportAttributeAccessIssue          = "error",
                    reportCallInDefaultInitializer      = "none",
                    reportCallIssue                     = "error",
                    reportConstantRedefinition          = "none",
                    reportDeprecated                    = "none",
                    reportDuplicateImport               = "none",
                    reportFunctionMemberAccess          = "error",
                    reportGeneralTypeIssues             = "error",
                    reportImplicitOverride              = "none",
                    reportImplicitStringConcatenation   = "none",
                    reportImportCycles                  = "none",
                    reportIncompatibleMethodOverride    = "error",
                    reportIncompatibleVariableOverride  = "error",
                    reportIncompleteStub                = "none",
                    reportInconsistentConstructor       = "none",
                    reportInconsistentOverload          = "error",
                    reportIndexIssue                    = "error",
                    reportInvalidStringEscapeSequence   = "warning",
                    reportInvalidStubStatement          = "none",
                    reportInvalidTypeArguments          = "error",
                    reportInvalidTypeForm               = "error",
                    reportInvalidTypeVarUse             = "warning",
                    reportMatchNotExhaustive            = "none",
                    reportMissingImports                = "error",
                    reportMissingModuleSource           = "warning",
                    reportMissingParameterType          = "none",
                    reportMissingSuperCall              = "none",
                    reportMissingTypeArgument           = "none",
                    reportMissingTypeStubs              = "none",
                    reportNoOverloadImplementation      = "error",
                    reportOperatorIssue                 = "error",
                    reportOptionalCall                  = "error",
                    reportOptionalContextManager        = "error",
                    reportOptionalIterable              = "error",
                    reportOptionalMemberAccess          = "error",
                    reportOptionalOperand               = "error",
                    reportOptionalSubscript             = "error",
                    reportOverlappingOverload           = "error",
                    reportPossiblyUnboundVariable       = "error",
                    reportPrivateImportUsage            = "error",
                    reportPrivateUsage                  = "none",
                    reportPropertyTypeMismatch          = "none",
                    reportRedeclaration                 = "error",
                    reportReturnType                    = "error",
                    reportSelfClsParameterName          = "warning",
                    reportShadowedImports               = "none",
                    reportTypeCommentUsage              = "none",
                    reportTypedDictNotRequiredAccess    = "error",
                    reportUnboundVariable               = "error",
                    reportUndefinedVariable             = "error",
                    reportUnhashable                    = "error",
                    reportUninitializedInstanceVariable = "none",
                    reportUnknownArgumentType           = "none",
                    reportUnknownLambdaType             = "none",
                    reportUnknownMemberType             = "none",
                    reportUnknownParameterType          = "none",
                    reportUnknownVariableType           = "none",
                    reportUnnecessaryCast               = "none",
                    reportUnnecessaryComparison         = "none",
                    reportUnnecessaryContains           = "none",
                    reportUnnecessaryIsInstance         = "none",
                    reportUnnecessaryTypeIgnoreComment  = "none",
                    reportUnsupportedDunderAll          = "warning",
                    reportUntypedBaseClass              = "none",
                    reportUntypedClassDecorator         = "none",
                    reportUntypedFunctionDecorator      = "none",
                    reportUntypedNamedTuple             = "none",
                    reportUnusedCallResult              = "none",
                    reportUnusedClass                   = "none",
                    reportUnusedCoroutine               = "error",
                    reportUnusedExcept                  = "error",
                    reportUnusedExpression              = "warning",
                    reportUnusedFunction                = "none",
                    reportUnusedImport                  = "none",
                    reportUnusedVariable                = "none",
                    reportWildcardImportFromLibrary     = "warning",
                },
                include = { "src/**/*.py" },
                exclude = { "**/node_modules" },
                ignore = { "**/node_modules" },
                extraPaths = {},
                typeCheckingMode = "strict",
                -- typeshedPaths                default: []
                useLibraryCodeForTypes = true,
            },
            pythonPath = "python",
            -- venvPath = "",
        }
    }
}
