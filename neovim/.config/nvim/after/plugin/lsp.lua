local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
	'lua_ls',
	'rust_analyzer',
    'gopls',
})

lsp.configure('lua_ls', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})

local rust_lsp = lsp.build_options('rust_analyzer', {})

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
	['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
	['<C-y>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true, 
    }),
	['<C-Space>'] = cmp.mapping.complete(),
})

cmp_mappings['<CR>'] = nil
cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab'] = nil

local cmp_sources = lsp.defaults.cmp_sources()
table.insert(cmp_sources, { name = 'copilot', group_index = 2 })

lsp.setup_nvim_cmp({
	mapping = cmp_mappings,
    sources = cmp_sources
})

lsp.set_preferences({
	sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
	vim.keymap.set('n', '<leader>vws', vim.lsp.buf.workspace_symbol, opts)
	vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float, opts)
	vim.keymap.set('n', '[d', vim.diagnostic.goto_next, opts)
	vim.keymap.set('n', ']d', vim.diagnostic.goto_prev, opts)
	vim.keymap.set('n', '<leader>vca', vim.lsp.buf.code_action, opts)
	vim.keymap.set('n', '<leader>vrr', vim.lsp.buf.references, opts)
	vim.keymap.set('n', '<leader>vrn', vim.lsp.buf.rename, opts)
	vim.keymap.set('n', '<C-h>', vim.lsp.buf.signature_help, opts)
end)

lsp.setup()

require('rust-tools').setup({server = rust_lsp})
