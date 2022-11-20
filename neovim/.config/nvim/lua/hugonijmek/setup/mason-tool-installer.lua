require("mason-tool-installer").setup({
    ensure_installed = {
        'rustfmt',
    },

    run_on_start = true,
})
