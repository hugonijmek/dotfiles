local has_rust_tools, rust_tools = pcall(require, "rust-tools")
if not has_rust_tools then
    print("Rust tools not found, skipping rust-tools")
else
    rust_tools.setup ({
        tools = {
            autoSetHints = true,
            hover_with_actions = true,
            inlay_hints = {
                only_current_line = false,
                only_current_line_autocmd = "CursorHold",
                show_parameter_hints = true,
                parameter_hints_prefix = ":",
                other_hints_prefix = "!",
                highlight = "Comment",
            },
            hover_actions = {
                -- the border that is used for the hover window
                -- see vim.api.nvim_open_win()
                border = {
                    { "╭", "FloatBorder" },
                    { "─", "FloatBorder" },
                    { "╮", "FloatBorder" },
                    { "│", "FloatBorder" },
                    { "╯", "FloatBorder" },
                    { "─", "FloatBorder" },
                    { "╰", "FloatBorder" },
                    { "│", "FloatBorder" },
                },

                -- whether the hover action window gets automatically focused
                -- default: false
                auto_focus = false,
            },
            --server = {
            --    on_attach = lsp.on_attach,
            --},
        }
    })
end
