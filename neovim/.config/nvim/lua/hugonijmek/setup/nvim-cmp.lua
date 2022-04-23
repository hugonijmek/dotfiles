local ok, cmp = pcall(require, 'cmp')
if not ok then
    --TODO: inform user what went wrong
    return
end

local ok, luasnip = pcall(require, 'luasnip')
if not ok then
    --TODO: inform user what went wrong
    return
end

local check_backspace = function()
    local col = vim.fn.col "." - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping= {
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<CR>"] = cmp.mapping.confirm ({ select = true }),
--        ["<Tab>"] = cmp.mapping(function(fallback)
--            if cmp.visible() then
--                cmp.select_next_item()
--            elseif luasnip.expandable() then
--                luasnip.expand()
--            elseif luasnip.expand_or_jumpable() then
--                luasnip.expand_or_jump()
--            elseif check_backspace() then
--                fallback()
--            else
--                fallback()
--            end
--        end, { "i", "c" }),
--        ["<S-Tab>"] = cmp.mapping(function(fallback)
--            if cmp.visible() then
--                cmp.select_prev_item()
--            elseif luasnip.jumpable(-1) then
--                luasnip.jump(-1)
--            else
--                fallback()
--            end
--        end, { "i", "c"}),
    },
    sources = {
        { name = 'nvim_lua' },
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'luasnip' },
        { name = 'buffer', keyword_length = 5 },
    },
    sorting = {
        comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,

            function(entry1, entry2)
                local _, entry1_under = entry1.completion_item.label:find "^_+"
                local _, entry2_under = entry2.completion_item.label:find "^_+"
                entry1_under = entry1_under or 0
                entry2_under = entry2_under or 0
                if entry1_under > entry2_under then
                    return false
                elseif entry1_under < entry2_under then
                    return true
                end
            end,

            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        },
    },
    formatting = {
        fields = { "abbr", "menu" },
        format = function(entry, vim_item)
            vim_item.menu = ({
                luasnip = "[Snippet]",
                buffer = "[Buffer]",
                path = "[Path]",
            })[entry.source.name]
            return vim_item
        end,
    },

    experimental = {
        -- I like the new menu better! Nice work hrsh7th
        native_menu = false,

        -- Let's play with this for a day or two
        ghost_text = true,
    },
})
