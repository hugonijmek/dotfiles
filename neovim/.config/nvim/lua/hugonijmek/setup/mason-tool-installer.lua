require("mason-tool-installer").setup({
    ensure_installed = {
        'rustfmt',
        'codelldb'
    },

    run_on_start = true,
})
