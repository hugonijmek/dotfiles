local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer, close and reopen Neovim."
    vim.cmd [[packadd packer.nvim]]
end

-- Automatically reload noevim whenever we save plugins.lua
vim.cmd [[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]]

local ok, packer = pcall(require, "packer")
if not ok then
    return
end

packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

local function get_config(name)
    return string.format('require("hugonijmek/setup/%s")', name)
end

-- Install plugins here
return packer.startup(function(use)
    use "wbthomason/packer.nvim"

    -- theme
    use {
        "navarasu/onedark.nvim",
        config = get_config("onedark")
    }

    -- status bar
    use {
        'nvim-lualine/lualine.nvim',
        config = get_config("lualine"),
        requires = { "kyazdani42/nvim-web-devicons", opt = true }
    }

    -- lsp
    use {
        'neovim/nvim-lspconfig'
    }
    use {
        'williamboman/nvim-lsp-installer',
        config = get_config('lsp')
    }

    use {
        "hrsh7th/nvim-cmp",
        config = get_config("nvim-cmp")
    }
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-cmdline"
    use "hrsh7th/cmp-nvim-lua"
    use "hrsh7th/cmp-nvim-lsp"
    use "saadparwaiz1/cmp_luasnip"
    use "L3MON4D3/LuaSnip"

    --automatically sync on bootstrapping
    if PACKER_BOOTSTRAP then
        require('packer').sync()
    end
end)





--require "paq" {
--    "savq/paq-nvim";
--
--    "navarasu/onedark.nvim";
--
--    "nvim-lualine/lualine.nvim";
--    "kyazdani42/nvim-web-devicons";
--
--    'nvim-lua/plenary.nvim';
--    'nvim-telescope/telescope.nvim';
--
--    'neovim/nvim-lspconfig';
--}
--
--require('onedark').load()
--require('lualine').setup {
--    options = {
--        theme = 'onedark'
--    }
--}
--
--require('lspconfig').gopls.setup {}
