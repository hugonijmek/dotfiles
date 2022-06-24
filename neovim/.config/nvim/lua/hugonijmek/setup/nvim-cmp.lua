local cmp_status_ok, cmp = pcall(require, 'cmp')
if not cmp_status_ok then
    print('cmp not found')
    return
end

local luasnip_status_ok, luasnip = pcall(require, 'luasnip')
if not luasnip_status_ok then
    print("luasnip could not be found.")
    return
end

local kind_icons = {
    Class = " ",
    Color = " ",
    Constant = "ﲀ ",
    Constructor = " ",
    Enum = "練",
    EnumMember = " ",
    Event = " ",
    Field = " ",
    File = "",
    Folder = " ",
    Function = " ",
    Interface = "ﰮ ",
    Keyword = " ",
    Method = " ",
    Module = " ",
    Operator = "",
    Property = " ",
    Reference = " ",
    Snippet = " ",
    Struct = " ",
    Text = " ",
    TypeParameter = " ",
    Unit = "塞",
    Value = " ",
    Variable = " ",
    Copilot = " ",
}

local source_names = {
    nvim_lsp = "(LSP)",
    emoji = "(Emoji)",
    path = "(Path)",
    calc = "(Calc)",
    copilot = "(Copilot)",
    vsnip = "(Snippet)",
    luasnip = "(Snippet)",
    buffer = "(Buffer)",
    tmux = "(TMUX)",
}

local duplicates = {
    buffer = 1,
    path = 1,
    nvim_lsp = 0,
    luasnip = 1,
}

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping= {
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm ({ select = true }),
    },
    sources = {
        { name = 'copilot', max_item_count = 3 },
        { name = 'nvim_lua' },
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'luasnip' },
        { name = 'buffer', keyword_length = 5 },
    },
    formatting = {
      fields = { "kind", "abbr", "menu" },
      max_width = 0,
      duplicates_default = 0,
      format = function(entry, vim_item)
        local max_width = 0
        if max_width ~= 0 and #vim_item.abbr > max_width then
          vim_item.abbr = string.sub(vim_item.abbr, 1, max_width - 1) .. "…"
        end
        if entry.source.name == "copilot" then
            vim_item.kind = "Copilot"
        end
        vim_item.kind = kind_icons[vim_item.kind]
        vim_item.menu = source_names[entry.source.name]
        vim_item.dup = duplicates[entry.source.name]
          or 0
        return vim_item
      end,
    },
    completion = {
        keyword_length = 1,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },

    experimental = {
        -- I like the new menu better! Nice work hrsh7th
        native_menu = false,

        -- Let's play with this for a day or two
        ghost_text = true,
    },
})
