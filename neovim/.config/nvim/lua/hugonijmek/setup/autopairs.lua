--setup nvim-cmp
local status_autopairs_ok, autopairs = pcall(require, "nvim-autopairs")
if not status_autopairs_ok then
    return
end

autopairs.setup {

}

local status_autopairs_cmp_ok, autopairs_cmp = pcall(require, "nvim-autopairs.completion.cmp")
if not status_autopairs_cmp_ok then
    return
end
local status_cmp_ok, cmp = pcall(require, "cmp")
if not status_cmp_ok then
    print "CMP not found"
    return
end

cmp.event:on('confirm_done', autopairs_cmp.on_confirm_done())
