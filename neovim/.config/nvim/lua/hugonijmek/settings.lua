local options = {
    backup = false,
    cmdheight = 2,
    fileencoding = "utf-8",
    hlsearch = false,
    ignorecase = true,
    mouse = "a",
    showmode = false,
    showtabline = 2,
    tabstop = 4,
    softtabstop = 4,
    expandtab = true,
    smartindent = true,
    shiftwidth = 4,
    termguicolors = true,
    relativenumber = true,
    nu = true,
    numberwidth = 5,
    splitbelow = true,
    splitright = true,
    hidden = true,
    errorbells = false,
    scrolloff = 8,
    swapfile = false,
    undofile = true,
    signcolumn = "yes",
    wrap = false,
    updatetime = 50,
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]
