local ok, lsp_installer = pcall(require, 'nvim-lsp-installer')
if not ok then
    print('could not find nvim-lsp-installer')
    return
end

lsp_installer.on_server_ready(function(server)
    local opts = {}

    if server.name == "sumneko_lua" then
        local sumneko_opts = require('hugonijmek.setup.lsp-lua')
        opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
    end

    server:setup(opts)
end)
